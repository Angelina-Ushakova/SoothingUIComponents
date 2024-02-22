//
//  ProgressButton.swift
//  
//
//

import SwiftUI

public struct ProgressButton: View {
    @State private var progress: CGFloat = 0.0
    @State private var progressText: String = "0%"
    @State private var showCheckmark: Bool = false
    
    public var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 20)
                .opacity(0.3)
                .foregroundColor(Color.blue)
            
            Circle()
                .trim(from: 0.0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.blue)
                .rotationEffect(Angle(degrees: 270))
                .animation(.linear(duration: 2))
            
            if showCheckmark {
                Image(systemName: "checkmark")
                    .font(.largeTitle)
                    .foregroundColor(Color.blue)
            } else {
                Text(progressText)
                    .font(.title)
                    .foregroundColor(Color.blue)
            }
        }
        .onAppear() {
            Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                self.progress += 0.01
                self.progressText = "\(Int(self.progress * 100))%"
                if self.progress >= 1.0 {
                    self.showCheckmark = true
                    timer.invalidate()
                }
            }
        }
        .frame(width: 200, height: 200)
    }
}

