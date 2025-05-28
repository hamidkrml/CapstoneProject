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
    
    init() {
        do {
            modelContainer = try ModelContainer(for: Food.self)
            // Load food data when app starts
            FoodDataManager.shared.loadFoodData(modelContext: modelContainer.mainContext)
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
        }
        .modelContainer(modelContainer)
    }
}
