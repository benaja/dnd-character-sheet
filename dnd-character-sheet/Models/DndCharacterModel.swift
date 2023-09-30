//
//  DndCharacterModel.swift
//  dnd-character-sheet
//
//  Created by Benaja on 27.09.23.
//

import Foundation
import SwiftData

@Model
class DndCharacterModel: Identifiable {
    var id: UUID
    var name: String
    
    init(name: String) {
        self.id = UUID()
        self.name = name
    }
}
