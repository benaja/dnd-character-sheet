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

enum Dice: String, CaseIterable, Codable, Identifiable {
    case D4
    case D6
    case D8
    case D10
    case D12
    case D20
    
    var id: Self { self }
}

enum AttackType: String, CaseIterable, Codable, Identifiable {
    case Mele
    case Ranged
    
    var id: Self { self }
}

enum DamageType: String, CaseIterable, Codable, Identifiable {
    case Slashing
    case Percing
    case Bludgeoning
    case Poison
    case Acid
    case Fire
    case Cold
    case Radiant
    case Necrotic
    case Lightning
    case Thunder
    case Force
    case Psychic
    
    var id: Self { self }
}


@Model
class DndCharacter: Identifiable, ObservableObject {
    var id: UUID = UUID()
    var name: String = ""
    var race: String = ""
    var dndClass: String = ""
    var level: String = ""
    var totalLevel: Int = 1
    var profileImagePath: String? = nil
//    var profileImage: UIImage?
    
    var hp: Int = 15;
    var maxHp: Int = 22;
    var hidDice: String = "1w8"
    var ac: String = "18"
    var acModifier: String = ""
    
    var str = Stat(name: "Strength")
    var dex = Stat(name: "Dexterity")
    var con = Stat(name: "Constitution")
    var int = Stat(name: "Intelligence")
    var wis = Stat(name: "Wisdom")
    var cha = Stat(name: "Charisma")
    
    var speed: String = "30"
    var initiativeBonus: Int = 0
    var passivePerceptionBonus: Int = 0;
    var profBonus: Int = 2;
    
    var acrobatics = Skill(name: "Acrobatics")
    var animalHandling = Skill(name: "Animal Handling")
    var arcana = Skill(name: "Arcana")
    var athletics = Skill(name: "Athletics")
    var deception = Skill(name: "Deception")
    var history = Skill(name: "History")
    var insight = Skill(name: "Insight")
    var intimidation = Skill(name: "Intimidation")
    var investigation = Skill(name: "Investigation")
    var medicine = Skill(name: "Medicine")
    var nature = Skill(name: "Nature")
    var perception = Skill(name: "Perception")
    var performance = Skill(name: "Performance")
    var persuasion = Skill(name: "Persuasion")
    var religion = Skill(name: "Religion")
    var sleigthOfHand = Skill(name: "Sleigth Of Hand")
    var stealth = Skill(name: "Stealth")
    var survical = Skill(name: "Survival")
    
    var hitDice: Dice
    var remainingHitDice = 0
    
    var weapons: [Weapon] = []
    
    
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    
    
    init(id: UUID = UUID(), name: String, race: String, dndClass: String, level: String = "1", createdAt: Date = Date(), updatedAt: Date = Date(), totalLevel: Int = 1) {
        self.id = id
        self.name = name
        self.race = race
        self.dndClass = dndClass
        self.level = level
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.totalLevel = totalLevel
        
        self.profileImagePath = nil
        self.remainingHitDice = totalLevel
        self.hitDice = Dice.D8
    }
   
    
        


    struct Stat: Codable {
        var name: String = ""
        var value: Int = 10
        var bonus: Int = 0;
        var prof: Bool = false
        
        var modifier: Int {
            (value / 2) - 5
        }
        
        func savingThrowMod(profBonus: Int) -> Int {
            modifier + bonus + (prof ? profBonus : 0)
        }
      
        init(name: String) {
            self.name = name
        }
    }
    
    struct Weapon: Codable {
        var name: String = ""
        var proficient: Bool = false
        var attackType: AttackType = .Mele
        var reach: String = "5ft"
        var range: String = "30ft/120ft"
        var damageType: DamageType = .Slashing
        var cost: Double = 0.0
        var weight: Double = 0.0
        var isMagic: Bool = false
        
        var hasAmo: Bool = false
        var amo: Int = 0
    }
    

    
    struct Skill: Codable {
        var prof = false
        var exp = false
        var bonus = 0
        var name: String = ""
    }
        
    

    
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
}

extension DndCharacter {
    static let sampleData: [DndCharacter] = [
        DndCharacter(name: "Val", race: "Elf", dndClass: "Barbarien", level: "1", totalLevel: 1),
        DndCharacter(name: "Milo", race: "Halfling", dndClass: "Fihter", level: "3", totalLevel: 3),
        DndCharacter(name: "Halgur", race: "Orc", dndClass: "Wizard", level: "8", totalLevel: 8),
    ]
    
    
    static let emptyCharacter = {
        DndCharacter(name: "", race: "", dndClass: "", level: "1")
    }
}

