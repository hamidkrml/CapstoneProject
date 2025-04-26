//
//  sporsayfasinenum.swift
//  BitirmeProjesi
//
//  Created by hamid on 23.02.25.
//
import SwiftUI


enum DetailPage{
    
    ///spor sayfsinda vievler
    case squat
    case bicep
    case lateral
    case dumbel
    case LungesSag
    case LungesSol
    
    
    ///chart sayfasindaki  viewler
    case level1
    case level2
    case level3
}


func getDetailView(for page: DetailPage) -> AnyView {
    switch page {
    case .squat:
        return AnyView(Squatvid())
    case .bicep:
        return AnyView(Bicepvid())
    case .lateral:
        return AnyView(Standingvid())
    case .dumbel:
        return AnyView(Pressvid())
    case .LungesSag:
        return AnyView(Lsagvid())
    case .LungesSol:
        return AnyView(Lsolvid())
    case .level1:
        return AnyView(Pressvid())
    case .level2:
        return AnyView(Pressvid())
    case .level3:
        return AnyView(Pressvid())
    }
}
