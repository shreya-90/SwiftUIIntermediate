//
//  DownloadWithCombine.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Shreya Pallan on 15/10/24.
//

import SwiftUI
import Combine

struct PostModel: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineViewModel: ObservableObject {
    @Published var posts: [PostModel] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
       getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        /* Combine discussion :-
         
        //1. signup for monthly sub for pkg to be delivered
        //2. package getting made BTS
        //3. receive the package at your front door
        //4. make sure box is not damaged
        //5. open and make sure the item is correct
        //6. use the item!!!
        //7. cancellable at any time
        
        //1. create the publisher
        //2. subscribe publisher on background thread
        //3. receive on main thread
        //4. tryMap (check that data is good)
        //5. decode (decode Data into PostModels)
        //6. sink ( put them into our app )
        //7. store ( to cancel subscription of needed )
         */
        
        URLSession.shared.dataTaskPublisher(for: url)
           // .subscribe(on: DispatchQueue.global(qos: .background)) 
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] returnedPosts in
                self?.posts = returnedPosts
            })
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
            
        }
        return output.data
    }
}

struct DownloadWithCombine: View {
    
    @StateObject var vm = DownloadWithCombineViewModel()
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    DownloadWithCombine()
}
