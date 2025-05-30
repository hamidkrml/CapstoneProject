import SwiftData
import Foundation

@MainActor
struct VeriKayit {
    static let shared = VeriKayit()
    
    private init() {}
    
    static func getCurrentWorkoutSession(modelContext: ModelContext) -> SporData {
        // Bugünkü tarihle kayıt var mı kontrol et
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!

        let descriptor = FetchDescriptor<SporData>(
            predicate: #Predicate { workout in
                workout.date >= today && workout.date < tomorrow
            }
        )
        
        if let existingWorkout = try? modelContext.fetch(descriptor).first {
            return existingWorkout
        }
        
        // Yeni kayıt oluştur
        let newWorkout = SporData()
        modelContext.insert(newWorkout)
        return newWorkout
    }
    
    static func saveExerciseCount(
        modelContext: ModelContext,
        squat: Int? = nil,
        biceps: Int? = nil,
        lungeSol: Int? = nil,
        lungeSag: Int? = nil,
        press: Int? = nil,
        standing: Int? = nil
    ) {
        let currentWorkout = getCurrentWorkoutSession(modelContext: modelContext)
        
        if let squat = squat { currentWorkout.squat += squat }
        if let biceps = biceps { currentWorkout.biceps += biceps }
        if let lungeSol = lungeSol { currentWorkout.lungeSol += lungeSol }
        if let lungeSag = lungeSag { currentWorkout.lungeSag += lungeSag }
        if let press = press { currentWorkout.press += press }
        if let standing = standing { currentWorkout.standing += standing }
        
        do {
            try modelContext.save()
            print("✅ Egzersiz verileri güncellendi")
        } catch {
            print("❌ Veri kaydetme hatası: \(error)")
        }
    }
}
