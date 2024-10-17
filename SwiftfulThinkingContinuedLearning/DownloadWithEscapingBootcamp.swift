//
//  DownloadWithEscaping.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Shreya Pallan on 15/10/24.
//

import SwiftUI


//struct PostModel: Codable, Identifiable {
//    let userId: Int
//    let id: Int
//    let title: String
//    let body: String
//}

class DownloadWithEscapingBootcampViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    init() {
        getPosts()
    }
    
    func getPosts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        downloadData(from: url) { returnedData in
            if let data = returnedData {
                guard let newPosts = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
                
                DispatchQueue.main.async { [weak self] in
                    self?.posts = newPosts
                }
            } else {
                print("No data returned")
            }
        }
        
    }
    
    
    // Returns generic Data
    func downloadData(from url: URL, completionHandler: @escaping (Data?) -> ()) {
        URLSession.shared.dataTask(with: url) {  (data, response, error) in
            
            guard
            let data = data,
            error == nil,
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error downloading Data")
                completionHandler(nil)
                return
            }
            
            //only for printing out the data in readable form
            let jsonString = String(data: data, encoding: .utf8)
            print(jsonString)
            
           completionHandler(data)
 
        }.resume()
    }
}

struct DownloadWithEscapingBootcamp: View {
    
    @StateObject var vm = DownloadWithEscapingBootcampViewModel()
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
    DownloadWithEscapingBootcamp()
}
