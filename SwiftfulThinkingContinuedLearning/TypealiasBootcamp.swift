//
//  TypealiasBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Shreya Pallan on 14/10/24.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

typealias TVModel = MovieModel

struct TypealiasBootcamp: View {
    
    @State var tvmodel: TVModel = TVModel(title: "TV Title", director: "Joe", count: 5)
    
    var body: some View {
        VStack {
            Text(tvmodel.title)
            Text(tvmodel.director)
            Text("\(tvmodel.count)")
            
        }
    }
}

#Preview {
    TypealiasBootcamp()
}
