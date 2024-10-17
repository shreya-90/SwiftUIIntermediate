//
//  LongPressGestureBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Shreya Pallan on 01/10/24.
//

import SwiftUI

struct LongPressGestureBootcamp: View {
    
    @State var isComplete: Bool = false
    @State var isSuccess: Bool = false
    
    var body: some View {
        
        
        VStack {
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                .frame(height: 55)
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
            
           
            HStack {
                Text("CLICK HERE")
                    .padding()
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) {
                        // called at the minimum duration
                        withAnimation(.easeInOut) {
                            isSuccess.toggle()
                        }
                        
                    } onPressingChanged: { isPressing in
                        //click down
                        //lift off button
                        //so start of press -> min duration
                        if isPressing {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                isComplete.toggle()
                            }
                        } else {
                            //click up
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                
                                if !isSuccess {
                                    withAnimation(.easeInOut) {
                                        isComplete = false
                                    }
                                }
                                
                            }
                            
                            
                        }
                    }
                    

                    
                
                Text("RESET")
                .foregroundColor(.white)
                .padding()
                .background(.black)
                .cornerRadius(10)
                .onTapGesture {
                    isComplete = false
                    isSuccess = false
                }
            }
        }
        
        
       
//        Text(isComplete ? "Complete"
//             : "Not Complete")
//            .padding()
//            .padding(.horizontal)
//            .background(isComplete ? .green : .gray)
//            .cornerRadius(10)
//            .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 500, perform: {
//                isComplete.toggle()
//            })
          
    }
}

#Preview {
    LongPressGestureBootcamp()
}
