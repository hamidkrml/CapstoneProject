//
//  RegisterViewWrapper.swift
//  BitirmeProjesi
//
//  Created by hamid karimli on 26.05.2025.
//

import SwiftData
import SwiftUI
struct RegisterViewWrapper: View {
    @Environment(\.modelContext) private var modelContext
    @State private var registerViewModel1: registerViewModel? = nil

    var body: some View {
        Group {
            if let vm = registerViewModel1 {
                tanitimSayfasi()
                    .environmentObject(vm)
            } else {
                ProgressView("Yükleniyor...")
            }
        }
        .onAppear {
            if registerViewModel1 == nil {
                registerViewModel1 = registerViewModel(modelContext: modelContext)
            }
        }
    }
}
