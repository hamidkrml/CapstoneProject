//
//  File.swift
//  BitirmeProjesi
//
//  Created by hamid on 26.04.2025.
//


import SwiftUI
import SwiftData

class ExerciseTotalsManager: ObservableObject {
    @Published var exerciseTotals: [(exercise: String, total: Int)] = []
    
    // Constructor to initialize with records
    init(records: [SporData]) {
        self.exerciseTotals = [
            ("Squat", records.reduce(0) { $0 + ($1.squat1 ?? 0) }),
            ("Biceps", records.reduce(0) { $0 + ($1.biceps ?? 0) }),
            ("Lunge Sol", records.reduce(0) { $0 + ($1.lungeSol ?? 0) }),
            ("Lunge Sag", records.reduce(0) { $0 + ($1.lungeSag ?? 0) }),
            ("Press", records.reduce(0) { $0 + ($1.press ?? 0) }),
            ("Standing", records.reduce(0) { $0 + ($1.standing ?? 0) })
        ]
    }
}
