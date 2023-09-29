//
//  DndCharacterModel.swift
//  dnd-character-sheet
//
//  Created by Benaja on 27.09.23.
//

import Foundation

protocol BaseCharacter {
    var id: UUID { get set }
    var name: String { get }
    var race: String { get }
    var dndClass: String { get }
    var level: String { get }
    var profileImagePath: String? { get }
}

struct DndCharacterModel: BaseCharacter {
    var id: UUID
    var name: String
    var race: String
    var dndClass: String
    var level: String
    var profileImagePath: String?
}
