//
//  TimerBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Shreya Pallan on 15/10/24.
//

import SwiftUI

struct TimerBootcamp: View {
    
    let timer  = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    //current Time
    /*
    @State var currentDate = Date()

    var dateFormater: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }
     */
    
    //countdown 
    /*
    @State var count: Int = 10
    @State var finishedText: String? = nil
    */
    
    //Countdown to date/ one hour
    /*
    @State var timeRemaning: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
    
    func updateRemainingTime() {
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaning = "\(hour):\(minute):\(second)"
    }
     */
    
    //Anumation Counter
    @State var count = 1
    
    var body: some View {
        ZStack {
            RadialGradient(colors: [Color.red, Color.blue],
                           center: .center,
                           startRadius: 5,
                           endRadius: 500)
            .ignoresSafeArea()
            
//            Text(timeRemaning)
//                .font(.system(size: 100, weight: .semibold, design: .rounded))
//                .foregroundColor(.white)
//                .lineLimit(1)
//                .minimumScaleFactor(0.1)
//                .padding()
            
            
            //animation
//            HStack(spacing: 15) {
//                Circle()
//                    .offset(y: count == 1 ? -20 : 0)
//                Circle()
//                    .offset(y: count == 2 ? -20 : 0)
//                Circle()
//                    .offset(y: count == 3 ? -20 : 0)
//            }
//            .foregroundColor(.white)
//            .frame(width: 200)
            
            TabView(selection: $count,
                    content:  {
                Rectangle()
                    .foregroundColor(.red)
                    .tag(1)
                
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(2)
                
                Rectangle()
                    .foregroundColor(.orange)
                    .tag(3)
                
                Rectangle()
                    .foregroundColor(.pink)
                    .tag(4)
                
                Rectangle()
                    .foregroundColor(.yellow)
                    .tag(5)
            })
            .tabViewStyle(.page)
            .frame(height: 200)
            
            
        }.onReceive(timer, perform: { value in
            withAnimation(.default) {
                count = count == 5 ? 1 : (count + 1)
            }
           
            
        })
    }
}

#Preview {
    TimerBootcamp()
}
