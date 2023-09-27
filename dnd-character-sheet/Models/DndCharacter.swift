//
//  DndCharacter.swift
//  dnd-character-sheet
//
//  Created by Benaja on 26.09.23.
//

import SwiftUI
import PhotosUI
import CoreTransferable

@propertyWrapper
public struct CodableIgnored<T>: Codable {
    public var wrappedValue: T?
    
    public init(wrappedValue: T?) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        self.wrappedValue = nil
    }
    
    public func encode(to encoder: Encoder) throws {
        // Do nothing
    }
}

extension KeyedDecodingContainer {
    public func decode<T>(
        _ type: CodableIgnored<T>.Type,
        forKey key: Self.Key) throws -> CodableIgnored<T>
    {
        return CodableIgnored(wrappedValue: nil)
    }
}

extension KeyedEncodingContainer {
    public mutating func encode<T>(
        _ value: CodableIgnored<T>,
        forKey key: KeyedEncodingContainer<K>.Key) throws
    {
        // Do nothing
    }
}


struct DndCharacter: Identifiable, Codable {
    var id: UUID
    var name: String
    var race: String
    var dndClass: String
    var level: Int
    var profileImagePath: String?
    
    var profileImage: UIImage?
    
    init(id: UUID = UUID(), name: String, race: String, dndClass: String, level: Int = 1) {
        self.id = id
        self.name = name
        self.race = race
        self.dndClass = dndClass
        self.level = level
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(UUID.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        race = try values.decode(String.self, forKey: .race)
        dndClass = try values.decodeIfPresent(String.self, forKey: .dndClass) ?? ""
        level = try values.decode(Int.self, forKey: .level)
        profileImagePath = try values.decode(String?.self, forKey: .profileImagePath)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case race
        case dndClass
        case level
        case profileImagePath
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(race, forKey: .race)
        try container.encode(level, forKey: .level)
        try container.encode(dndClass, forKey: .dndClass)
        try container.encode(profileImagePath, forKey: .profileImagePath)
    }

}

extension DndCharacter {
    static let sampleData: [DndCharacter] =
    [
        DndCharacter(name: "Val", race: "Elf", dndClass: "Barbarien", level: 1),
        DndCharacter(name: "Milo", race: "Halfling", dndClass: "Fihter", level: 3),
        DndCharacter(name: "Halgur", race: "Orc", dndClass: "Wizard", level: 8),
    ]
    
    
    static let emptyCharacter = {
        DndCharacter(name: "", race: "", dndClass: "", level: 1)
    }
}

