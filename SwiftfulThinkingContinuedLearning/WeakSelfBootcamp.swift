//
//  WeakSelfBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Shreya Pallan on 14/10/24.
//

import SwiftUI

struct WeakSelfBootcamp: View {
    
    @AppStorage("count") var count: Int?
    
    
    init() {
        count = 0
    }
    var body: some View {
        NavigationView {
          
                NavigationLink("NAVIGATE") {
                    WeakSelfSecondScreen()
                }
                .navigationTitle("Screen 1")
 
        }
        .overlay(alignment: .topTrailing) {
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color.green)
                .cornerRadius(10)
                .padding()
            
        }
    }
}

struct WeakSelfSecondScreen: View {
    
    @StateObject var vm = WeakSelfSecondScreenViewModel()
    
    var body: some View {
        
        VStack {
            Text("Second screen")
                .font(.largeTitle)
                .foregroundColor(.red)
            
            if let data = vm.data {
                Text(data)
            }
        }
    }
    
}

class WeakSelfSecondScreenViewModel: ObservableObject {
    @Published var data: String? = nil
    
    
    init() {
        print("INITIALISE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.setValue(currentCount + 1, forKey: "count")
        getData()
    }
    
    deinit {
        print("DEINITIALISE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.setValue(currentCount - 1, forKey: "count")
    }
    
    func getData() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
            self?.data = "NEW DATA!!!"
        }
       
    }
}

#Preview {
    WeakSelfBootcamp()
}
