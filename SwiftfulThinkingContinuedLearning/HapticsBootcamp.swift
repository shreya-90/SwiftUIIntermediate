//
//  HapticsBootcamp.swift
//  SwiftfulThinkingContinuedLearning
//
//  Created by Shreya Pallan on 09/10/24.
//

import SwiftUI


class HapticsManager {
    static let hapticsManager = HapticsManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct HapticsBootcamp: View {
    var body: some View {
        VStack {
            Button("success") { HapticsManager().notification(type: .success) }
            Button("warning") { HapticsManager().notification(type: .error) }
            Button("error") { HapticsManager().notification(type: .warning) }
            
            Divider()
            
            Button("soft") { HapticsManager().impact(style: .soft)  }
            Button("light") { HapticsManager().impact(style: .light)  }
            Button("medium") { HapticsManager().impact(style: .medium)  }
            Button("heavy") { HapticsManager().impact(style: .heavy)  }
            Button("rigid") { HapticsManager().impact(style: .rigid)  }



        }
    }
}

#Preview {
    HapticsBootcamp()
}
