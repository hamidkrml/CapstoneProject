import Foundation
import SwiftData

@Model
final class SporData {
    var date: Date = Date()
    var squat: Int = 0
    var biceps: Int = 0
    var lungeSol: Int = 0
    var lungeSag: Int = 0
    var press: Int = 0
    var standing: Int = 0

    init(squat: Int = 0, biceps: Int = 0, lungeSol: Int = 0,
         lungeSag: Int = 0, press: Int = 0, standing: Int = 0) {
        self.squat = squat
        self.biceps = biceps
        self.lungeSol = lungeSol
        self.lungeSag = lungeSag
        self.press = press
        self.standing = standing
    }
    
    func totalCount() -> Int {
        return squat + biceps + lungeSol + lungeSag + press + standing
    }
}
