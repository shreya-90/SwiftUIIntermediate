//
//  ScrollViewReaderBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Shreya Pallan on 07/10/24.
//

import SwiftUI

struct ScrollViewReaderBootcamp: View {
    
    @State var textFieldText: String = ""
    @State var scrollToIndex: Int = 0
    
    var body: some View {
        VStack {
            TextField("Enter a # here...", text: $textFieldText)
                .frame(height: 55)
                .border(Color.gray)
                .padding()
                .keyboardType(.numberPad)
            
            Button("Scroll now") {
                withAnimation(.spring()) {
                    if let index = Int(textFieldText) {
                        scrollToIndex = index
                    }
                       
                }
            }
            
            ScrollView {
                
                ScrollViewReader { proxy in
                    
                    ForEach(0..<50) { index in
                        Text("This is item no \(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) { oldValue, newValue in
                        proxy.scrollTo(newValue, anchor: .top)
                    }
                }
            }
        }
    }
}


#Preview {
    ScrollViewReaderBootcamp()
}
