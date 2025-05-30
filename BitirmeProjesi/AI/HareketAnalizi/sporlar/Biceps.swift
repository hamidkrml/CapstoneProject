import SwiftUI
import QuickPoseCore
import QuickPoseSwiftUI
import SwiftData

struct BicepsView: View {
    @Environment(\.modelContext) var modelContext
    

    @State private var feedbackText: String? = nil
    @State var overlayImag: UIImage?
    @State private var counter = QuickPoseThresholdCounter()
    @State private var biceps: Int = 0
    @State var scale = 1.0

   

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                QuickPoseCameraView(useFrontCamera: true, delegate: QuickPoseManager.shared)
                QuickPoseOverlayView(overlayImage: $overlayImag)
            }
            .frame(width: geometry.size.width)
            .edgesIgnoringSafeArea(.all)
            .overlay(alignment: .top) {
                VStack {
                    if let feedbackText = feedbackText {
                        Text(feedbackText)
                            .foregroundColor(.yellow)
                            .font(.system(size: 32))
                            .padding(10)
                            .scaleEffect(scale)
                    }
                }
            }
            .onAppear {
               

                let greenHighlightStyle = QuickPose.Style(conditionalColors: [
                    QuickPose.Style.ConditionalColor(min: 0.4, max: nil, color: UIColor.yellow)
                ])

                QuickPoseManager.shared.start(
                    features: [.fitness(.bicepCurls, style: greenHighlightStyle)],
                    onFrame: { status, image, features, feedback, landmarks in

                        overlayImag = image
                        if let result = features.values.first {
                            let counterState = counter.count(result.value)
                            biceps = counterState.count

                            feedbackText = ("Biceps sayısı: \(biceps)")
                            
                            // Biceps değerini güncelle
                           
                        }
                    }
                )
            }
            .onDisappear {
                VeriKayit.saveExerciseCount(
                    modelContext: modelContext,
                    biceps: biceps
                )
                QuickPoseManager.shared.stop()
            }
        }
    }
}

