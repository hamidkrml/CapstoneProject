import SwiftUI
import SwiftData
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
@main
struct BitirmeProjesiApp: App {
    let modelContainer: ModelContainer
    let calorieTracker: CalorieTracker
    
    init() {
        do {
            let schema = Schema([
                Food.self,
                SporData.self,
                KullanciBilgileri.self,
                DailyNutrition.self
            ])
            
            let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            calorieTracker = CalorieTracker(modelContext: modelContainer.mainContext)
            
            // Food verilerini yükle
            FoodDataManager.shared.loadFoodData(modelContext: modelContainer.mainContext)
        } catch {
            fatalError("ModelContainer oluşturulamadı: \(error)")
        }
    }
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                GirisVeyaAtla()
            }
            .modelContext(modelContainer.mainContext)
            .environmentObject(registerViewModel(modelContext: modelContainer.mainContext))
            .environmentObject(calorieTracker)
        }
        .modelContainer(modelContainer)
    }
}
