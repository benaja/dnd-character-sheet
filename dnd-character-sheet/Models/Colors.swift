//
//  Colors.swift
//  dnd-character-sheet
//
//  Created by Benaja on 04.10.2023.
//

import Foundation
import SwiftUI


enum Colors: String, CaseIterable, Identifiable {
    case PrimaryBackground
    case ElevatedBackground
    
    var id: Self { self }
    
    var color: Color {
        Color(rawValue)
    }
}
