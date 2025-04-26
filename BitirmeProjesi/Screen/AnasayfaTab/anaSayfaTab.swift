import SwiftUI

struct ContentView: View {
    @State private var records: [SporData] = []
    var body: some View {
        
        VStack{
            TabView  {
                
                spor()
                    .tabItem {
                        Label("Fitnes", systemImage: "figure.dance")
                            .foregroundColor(.white)
                            .opacity(0.8)
                    }
                
                    Diyet()
                    .tabItem {
                        Label("Diyet", systemImage: "heart.text.clipboard.fill")
                            .foregroundColor(.white)
                            .opacity(0.8)
                    }
                
                
                istatisticView(records: records)
                    .tabItem {
                        Label("Level", systemImage: "slider.horizontal.2.arrow.trianglehead.counterclockwise")
                            .foregroundColor(.white)
                            .opacity(0.8)
                    }
                ProfilSayfasi()
                    .tabItem {
                        Label("hesap ", systemImage: "lock.fill")
                            .foregroundColor(.white)
                            .opacity(0.8)
                    }
                     
            }
        }
       
        .accentColor(.white) // Aktif sekme beyaz olacak
       .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    ContentView()
}
