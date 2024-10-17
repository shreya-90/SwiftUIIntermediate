//
//  MaskBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Shreya Pallan on 09/10/24.
//

import SwiftUI

struct MaskBootcamp: View {
    
    @State var rating: Int = 2
    
    var body: some View {
            
        ZStack {
            starsView
                .overlay(
                    overlayView
                        .mask(starsView)
                )
        }
    }
    
    private var overlayView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
        }
        .allowsHitTesting(false)
    }
    
    private var starsView: some View {
        HStack {
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundColor(Color.gray)
                    .onTapGesture {
                        withAnimation {
                            rating = index
                        }
                    }
            }
           
        }
    }
}


#Preview {
    MaskBootcamp()
}
