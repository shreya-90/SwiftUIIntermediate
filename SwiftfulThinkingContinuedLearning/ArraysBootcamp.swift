//
//  ArraysBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Shreya Pallan on 10/10/24.
//

import SwiftUI


struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func updateFilteredArray() {
        // sort
        // filter
        // map
        
//        filteredArray = dataArray.sorted { user1, user2 in
//            return user1.points > user2.points
//        }
       
//        filteredArray = dataArray.sorted(by: { $0.points > $1.points })
        
        // filter
//        filteredArray = dataArray.filter { user in
//            return user.isVerified
//        }
        
//        filteredArray = dataArray.filter { $0.isVerified }
        
        
//        mappedArray = dataArray.map({ (user) -> String in
//            return user.name ?? "ERROR"
//        })
//        
//        mappedArray = dataArray.map { $0.name }
        
//        mappedArray = dataArray.compactMap { user -> String? in
//            return user.name ?? "ERROR"
//        }
        
//        mappedArray = dataArray.compactMap { $0.name }
       
        
        mappedArray = dataArray.sorted {$0.points > $1.points }
            .filter { $0.isVerified }
            .compactMap { $0.name }
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Nick", points: 5, isVerified: true)
        let user2 = UserModel(name: "Chris", points: 0, isVerified: true)
        let user3 = UserModel(name: "Joe", points: 20, isVerified: true)
        let user4 = UserModel(name: nil, points: 50, isVerified: true)
        let user5 = UserModel(name: "Samantha", points: 45, isVerified: true)
        let user6 = UserModel(name: "Jason", points: 75, isVerified: true)
        let user7 = UserModel(name: "Sarah", points: 95, isVerified: true)
        let user8 = UserModel(name: "Lisa", points: 51, isVerified: true)
        let user9 = UserModel(name: "Steve", points: 3, isVerified: true)
        let user10 = UserModel(name: "Amanda", points: 40, isVerified: true)
        
        self.dataArray.append(contentsOf: [user1, user2, user3, user4,user5, user6, user7, user8, user9, user10])
    }
}

struct ArraysBootcamp: View {
    
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 10) {
                
                ForEach(vm.mappedArray, id: \.self) { name in
                    Text(name)
                        .font(.title)
                }
//                ForEach(vm.filteredArray) { user in
//                    VStack(alignment: .leading) {
//                        Text(user.name)
//                            .font(.headline)
//                        
//                        HStack {
//                            Text("Points: \(user.points)")
//                            Spacer()
//                            if user.isVerified {
//                                Image(systemName: "flame.fill")
//                            }
//                            
//                        }
//                    }
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(.blue)
//                    .padding(.horizontal)
//                }
            }
        }
    }
}

#Preview {
    ArraysBootcamp()
}
