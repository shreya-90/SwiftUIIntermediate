//
//  MultipleSheetsBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Shreya Pallan on 08/10/24.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}


//1 - Use a binding
//2 - use multiple sheets
//3 - use the item approach

struct MultipleSheetsBootcamp: View {
    
    @State private var selectedModel: RandomModel? = nil
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                ForEach(0..<40) { index in
                    Button("Button \(index)") {
                        selectedModel = RandomModel(title: "\(index)")
                    }
                }
            }
            .sheet(item: $selectedModel) { model in
                NextScreen(selectedModel: model)
        }
        }
//        .sheet(isPresented: $showSheet, content: {
//            NextScreen(selectedModel: selectedModel)
//        })
    }
}

struct NextScreen: View {
    
    let selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

#Preview {
    MultipleSheetsBootcamp()
}
