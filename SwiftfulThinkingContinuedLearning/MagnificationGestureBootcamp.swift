//
//  MagnificationGestureBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Shreya Pallan on 02/10/24.
//

import SwiftUI

struct MagnificationGestureBootcamp: View {
    
    @State private var currentValue: CGFloat = 0
    @State private var lastValue: CGFloat = 0
    
    var body: some View {
        
        VStack {
            HStack {
                Circle().frame(width: 35, height: 35)
                Text("Swiftful Thinking")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            Rectangle()
                .frame(height: 300)
                .scaleEffect(1 + currentValue)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            currentValue = value - 1
                        }
                        .onEnded { value in
                            withAnimation(.spring) {
                                currentValue = 0
                            }
                            
                        }
                )
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .padding(.horizontal)
            .font(.headline)
            
            Text("This is the caption for my photo")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            
        }
        
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//            .font(.title)
//            .padding(40)
//            .background(Color.red.cornerRadius(10))
//            .scaleEffect(1 + currentValue + lastValue)
//            .gesture(
//               MagnifyGesture()
//                
//                .onChanged { value in
//                    currentValue = value.magnification - 1
//                   
//                }
//                .onEnded { value in
//                    lastValue += currentValue
//                    currentValue = 0
//                }
//            )
    }
    
}

#Preview {
    MagnificationGestureBootcamp()
}
