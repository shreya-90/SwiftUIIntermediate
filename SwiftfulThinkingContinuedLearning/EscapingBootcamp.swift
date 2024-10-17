//
//  EscapingBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Shreya Pallan on 14/10/24.
//

import SwiftUI

class EscapingBootcampViewModel: ObservableObject {
    @Published var data: String = "Hello"
    
    func getData() {
//        downloadData3 { [weak self] returnedData in
//            self?.data = returnedData
//        }
        
        downloadData5 { [weak self] returnedData in
            self?.data = returnedData.data
        }
    }
    
    private func downloadData() -> String {
        return "NEW DATA!!!"
    }
    
    private func downloadData2(completionHandler: (String) -> ()) {
            completionHandler("New Data!!!")
    }
    
    private func downloadData3(completionHandler: @escaping (String) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completionHandler("New Data!!!")
        }
    }
    
    private func downloadData4(completionHandler: @escaping (DownloadResult) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completionHandler(DownloadResult(data: "New Data!!!"))
        }
    }
    
    private func downloadData5(completionHandler: @escaping DownloadCompletion) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            completionHandler(DownloadResult(data: "New Data!!!"))
        }
    }
}

struct DownloadResult {
    let data: String
}

typealias DownloadCompletion = (DownloadResult) -> ()

struct EscapingBootcamp: View {
    @StateObject var vm = EscapingBootcampViewModel()
    
    
    var body: some View {
        Text(vm.data)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.blue)
            .onTapGesture {
                vm.getData()
            }
        
    }
}

#Preview {
    EscapingBootcamp()
}
