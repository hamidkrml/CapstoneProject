import SwiftData

@MainActor
struct verikayit {
    
    static let container: ModelContainer = {
        do {
            return try ModelContainer(for: SporData.self)
        } catch {
            fatalError("ModelContainer oluşturulamadı: \(error)")
        }
    }()
    
    
    static var modelContext: ModelContext {
        container.mainContext
    }
    
    static func saveLungeCount( lungeSolCount: Int = 0, bicepsCount:Int = 0,squatCount:Int = 0,lungeSagCount:Int = 0,stadingCount:Int = 0,pressCount:Int = 0 ) {
        let newlung = SporData(lungeSol: lungeSolCount)
        let newbicep = SporData(biceps: bicepsCount)
        let newsquat = SporData(squat: squatCount)
        let newlungS = SporData(lungeSag: lungeSagCount)
        let newstading = SporData(standing: stadingCount)
        let newpress = SporData(press: pressCount)
        modelContext.insert(newbicep)
        modelContext.insert(newlung)
        modelContext.insert(newsquat)
        modelContext.insert(newlungS)
        modelContext.insert(newstading)
        modelContext.insert(newpress)
        
        do {
            try modelContext.save()
//            print("Lunge Sol Sayısı Kaydedildi: \(lungeSolCount), Biceps Sayısı Kaydedildi: \(bicepsCount): Squat Sayısı Kaydedildi: \(squatCount), Lunge Sağ Sayısı Kaydedildi: \(lungeSagCount), Stading Sayısı Kaydedildi: \(stadingCount), Press Sayısı Kaydedildi: \(pressCount)")
//            
            
        } catch {
            print("Hata: Veri kaydedilemedi! \(error.localizedDescription)")
        }
    }
    
    
}
