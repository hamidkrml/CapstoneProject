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
    @StateObject private var calorieTracker: CalorieTracker
    
    init() {
        do {
            // Initialize ModelContainer first
            let container = try ModelContainer(for: Food.self, SporData.self, KullanciBilgileri.self, DailyNutrition.self)
            self.modelContainer = container
            
            // Create CalorieTracker after ModelContainer is initialized
            let tracker = CalorieTracker(modelContext: container.mainContext)
            self._calorieTracker = StateObject(wrappedValue: tracker)
            
            // Load food data when app starts
            FoodDataManager.shared.loadFoodData(modelContext: container.mainContext)
        } catch {
            fatalError("Could not initialize ModelContainer: \(error)")
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
