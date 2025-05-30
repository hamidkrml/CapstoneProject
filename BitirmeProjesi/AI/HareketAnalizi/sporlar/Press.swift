//
//  pushUps.swift
//  BitirmeProjesi
//
//  Created by hamid on 03.01.25.
//

import SwiftUI
import QuickPoseCore
import QuickPoseSwiftUI


struct Press: View {
    @Environment(\.modelContext) var modelContext // SwiftData Context

    @State var ov: UIImage?
    @State var scale = 1.0
    @State private var coun = QuickPoseThresholdCounter()
    @State private var hadi: String? = nil
    @State private var pres:Int = 0
    var body: some View {
    
        GeometryReader{ geometry in
            ZStack{
                QuickPoseCameraView(useFrontCamera: true, delegate: QuickPoseManager.shared)
                QuickPoseOverlayView(overlayImage: $ov)
            }
            .frame(width: geometry.size.width)
             .edgesIgnoringSafeArea(.all)
             .overlay(alignment: .top) {
                 if let feedbackText = hadi {
                     Text(feedbackText)
                .foregroundColor(Color.yellow).font(.system(size: 32))
                .padding(100)
                .scaleEffect(scale)
        }
    }
             .onAppear{
               
                 
                 let greenHighlightStyle = QuickPose.Style(conditionalColors: [QuickPose.Style.ConditionalColor(min: 0.4, max: nil, color: UIColor.yellow)])
                 QuickPoseManager.shared.start(features: [.fitness(.overheadDumbbellPress,style: greenHighlightStyle)],
                                               onFrame: { status, image, features, feedback, landmarks in
                     
                     ov = image
                     if let result = features.values.first  {
                         let counterState = coun.count(result.value)
                         hadi = ("Dumbbel: \(counterState.count) ")
                         
                         pres = counterState.count
                     }
                     
                     
                     
                 })
                 
                 
                 
                 
             }
             
             
             
             .onDisappear {
                 VeriKayit.saveExerciseCount(
                     modelContext: modelContext,
                     press: pres
                 )
                 QuickPoseManager.shared.stop()
             }
            
            
            
        }
    }
}
