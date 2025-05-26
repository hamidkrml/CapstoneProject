//
//  girisVey.swift
//  BitirmeProjesi
//
//  Created by hamid on 09.03.25.
//

import SwiftUI
struct GirisVeyaAtla: View {
    @StateObject var viewModel = FirbaseViewModel()
    
    var body: some View {
        Group {
            if viewModel.user1 == nil {
                RegisterViewWrapper()
            } else {
                ContentView()
            }
        }
    }
}
