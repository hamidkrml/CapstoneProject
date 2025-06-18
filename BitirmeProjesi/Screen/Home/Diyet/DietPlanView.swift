import SwiftUI

struct DietPlanView: View {
    let dietPlan: DietPlan

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Kişisel Diyet Planınız")
                .font(.headline)
                .bold()
            Text("Toplam Kalori: \(dietPlan.total_calories)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text("Kahvaltı").font(.subheadline).bold().padding(.top, 8)
            Text(dietPlan.meals.breakfast).font(.body)
            Text("Öğle Yemeği").font(.subheadline).bold().padding(.top, 8)
            Text(dietPlan.meals.lunch).font(.body)
            Text("Akşam Yemeği").font(.subheadline).bold().padding(.top, 8)
            Text(dietPlan.meals.dinner).font(.body)
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
} 