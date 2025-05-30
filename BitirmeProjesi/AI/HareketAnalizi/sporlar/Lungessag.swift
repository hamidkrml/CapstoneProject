//
//  Lungessol 2.swift
//  BitirmeProjesi
//
//  Created by hamid on 03.01.25.
//


import SwiftUI
import QuickPoseCore
import QuickPoseSwiftUI

struct Lungessag : View {
  
    @Environment(\.modelContext) var modelContext // SwiftData Context
    @State private var feedbackText: String? = nil
    @State var overlayImag: UIImage?
    @State private var counter = QuickPoseThresholdCounter()
    @State private var lungessag : Int = 0
    @State var scale = 1.0
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                QuickPoseCameraView(useFrontCamera: true, delegate: QuickPoseManager.shared)
                QuickPoseOverlayView(overlayImage: $overlayImag)
            }
            
            .frame(width: geometry.size.width)
             .edgesIgnoringSafeArea(.all)
             .overlay(alignment: .top) {
        if let feedbackText = feedbackText {
            Text(feedbackText)
                .foregroundColor(Color.yellow).font(.system(size: 32))
                .padding(100)
                .scaleEffect(scale)
        }
    }
            
            .onAppear{
                let greenHighlightStyle = QuickPose.Style(conditionalColors: [QuickPose.Style.ConditionalColor(min: 0.4, max: nil, color: UIColor.yellow)])
                QuickPoseManager.shared.start(features: [.fitness(.lunges(side: .right),style: greenHighlightStyle)],
                                 onFrame: { status, image, features, feedback, landmarks in
                    
                    overlayImag = image
                    if let result = features.values.first  {
                        let counterState = counter.count(result.value)
                        
                        feedbackText = ("sag \(counterState.count) ")
                        lungessag = counterState.count
                        
                    }
                    
                    
                    
                })
            }.onDisappear {
                VeriKayit.saveExerciseCount(
                    modelContext: modelContext,
                    lungeSag: lungessag
                )
                QuickPoseManager.shared.stop()
            }
        }
    }
    
}
