
import SwiftUI
import QuickPoseCore
import QuickPoseSwiftUI



struct SquatView: View {
    @Environment(\.modelContext) var modelContext // SwiftData Context

@State var squatCounter = QuickPoseThresholdCounter()
@State var overlayImage: UIImage?
@State var count: String? = nil
    @State private var squatt:Int = 0

@State var scale = 1.0
var body: some View {
    GeometryReader { geometry in
        ZStack {
            QuickPoseCameraView(useFrontCamera: true, delegate: QuickPoseManager.shared)
            
            QuickPoseOverlayView(overlayImage: $overlayImage)
        }
        
        
        .frame(width: geometry.size.width)
         .edgesIgnoringSafeArea(.all)
         .overlay(alignment: .top) {
    if let feedbackText = count {
        Text(feedbackText)
            .foregroundColor(Color.yellow).font(.system(size: 32))
            .padding(100)
            .scaleEffect(scale)
            }
        }
        
        .onAppear{
            let greenHighlightStyle = QuickPose.Style(conditionalColors: [QuickPose.Style.ConditionalColor(min: 0.4, max: nil, color: UIColor.yellow)])
            QuickPoseManager.shared.start(features: [.fitness(.squats,style: greenHighlightStyle)],
                                          onFrame: { status, image, features, feedback, landmarks in
                
                overlayImage = image
                if let result = features.values.first  {
                    let counterState = squatCounter.count(result.value)
                    count = ("squat \(counterState.count) ")
                    squatt = counterState.count
                    
                }
                
                
                
            })
            
            
            
            
        }
        
        
        
        .onDisappear {
            VeriKayit.saveExerciseCount(
                modelContext: modelContext,
               squat: squatt
            )
            QuickPoseManager.shared.stop()
        }
        
        
    }
}



}
