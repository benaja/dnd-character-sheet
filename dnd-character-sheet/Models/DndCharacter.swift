//
//  DndCharacter.swift
//  dnd-character-sheet
//
//  Created by Benaja on 26.09.23.
//

import SwiftUI
import PhotosUI
import CoreTransferable
import ObjectMapper
import SwiftData


@Model
class DndCharacter: Identifiable, ObservableObject {
    var id: UUID = UUID()
    var name: String = ""
    var race: String = ""
    var dndClass: String = ""
    var level: String = ""
    var profileImagePath: String? = nil
//    var profileImage: UIImage?
    
    var hp: Int = 15;
    var maxHp: Int = 22;
    var hidDice: String = "1w8"
    var ac: String = "18"
    
    var str = Stat()
    var dex = Stat()
    var con = Stat()
    var int = Stat()
    var wis = Stat()
    var cha = Stat()
    
    var speed: Double = 30
    var initiativeBonus: Int = 0
    var passivePerceptionBonus: Int = 0;
    var profBonus: Int = 2;
    
    var acrobatics = Skill()
    var animalHandling = Skill()
    var arcana = Skill()
    var athletics = Skill()
    var deception = Skill()
    var history = Skill()
    var insight = Skill()
    var intimidation = Skill()
    var investigation = Skill()
    var medicine = Skill()
    var nature = Skill()
    var perception = Skill()
    var performance = Skill()
    var persuasion = Skill()
    var religion = Skill()
    var sleigthOfHand = Skill()
    var stealth = Skill()
    var survical = Skill()
    
    
    
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    
    
    init(id: UUID = UUID(), name: String, race: String, dndClass: String, level: String = "1", createdAt: Date = Date(), updatedAt: Date = Date()) {
        self.id = id
        self.name = name
        self.race = race
        self.dndClass = dndClass
        self.level = level
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        
        self.profileImagePath = nil
//        str = Stat()
//        dex = Stat()
//        con = Stat()
//        int = Stat()
//        wis = Stat()
//        cha = Stat()
//        
//        acrobatics = Skill()
//        animalHandling = Skill()
//        arcana = Skill()
//        athletics = Skill()
//        deception = Skill()
//        history = Skill()
//        insight = Skill()
//        intimidation = Skill()
//        investigation = Skill()
//        medicine = Skill()
//        nature = Skill()
//        perception = Skill()
//        performance = Skill()
//        persuasion = Skill()
//        religion = Skill()
//        sleigthOfHand = Skill()
//        stealth = Skill()
//        survical = Skill()
    }
   
    
        


    struct Stat: Codable {
        var value: Int = 10
        var modifier: Int = 0;
        var prof: Bool = false
      
        init() {
            
        }
    }
    

    
    struct Skill: Codable {
        var prof = false
        var exp = false
        var modifier = 0
    }
        
    
    

//    
//    
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decode(UUID.self, forKey: .id)
//        name = try values.decode(String.self, forKey: .name)
//        race = try values.decode(String.self, forKey: .race)
//        dndClass = try values.decodeIfPresent(String.self, forKey: .dndClass) ?? ""
//        level = try values.decode(String.self, forKey: .level)
//        profileImagePath = try values.decodeIfPresent(String?.self, forKey: .profileImagePath) ?? nil
//        updatedAt = try values.decodeIfPresent(Date.self, forKey: .updatedAt) ?? Date()
//        createdAt = try values.decodeIfPresent(Date.self, forKey: .createdAt) ?? Date()
//        self.stats = try values.decodeIfPresent(Stats.self, forKey: .stats) ?? Stats()
//    }

    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case race
        case dndClass
        case level
        case profileImagePath
        case updatedAt
        case createdAt
        case stats
    }
    
    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(id, forKey: .id)
//        try container.encode(name, forKey: .name)
//        try container.encode(race, forKey: .race)
//        try container.encode(level, forKey: .level)
//        try container.encode(dndClass, forKey: .dndClass)
//        try container.encode(profileImagePath, forKey: .profileImagePath)
//    }

}

extension DndCharacter {
    static let sampleData: [DndCharacter] = [
        DndCharacter(name: "Val", race: "Elf", dndClass: "Barbarien", level: "1"),
        DndCharacter(name: "Milo", race: "Halfling", dndClass: "Fihter", level: "3"),
        DndCharacter(name: "Halgur", race: "Orc", dndClass: "Wizard", level: "8"),
    ]
    
    
    static let emptyCharacter = {
        DndCharacter(name: "", race: "", dndClass: "", level: "1")
    }
}

