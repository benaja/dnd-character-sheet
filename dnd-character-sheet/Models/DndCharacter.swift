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


@propertyWrapper
public struct NotCoded<Value> {
    private var value: Value?
    public init(wrappedValue: Value?) {
        self.value = wrappedValue
    }
    public var wrappedValue: Value? {
        get { value }
        set { self.value = newValue }
    }
}
extension NotCoded: Codable {
    public func encode(to encoder: Encoder) throws {
        // Skip encoding the wrapped value.
    }
    public init(from decoder: Decoder) throws {
        // The wrapped value is simply initialised to nil when decoded.
        self.value = nil
    }
}

struct StatContext: MapContext {
    var character: DndCharacter
}

struct SkillContext: MapContext {
    var stat: DndCharacter.Stat
}


struct StatTransformer: TransformType {
    var character: DndCharacter
    
    typealias Object = DndCharacter.Stat  // Replace YourType with the desired output type
    
    typealias JSON = String  // Replace JSONValue with the expected input type
    
    
    func transformFromJSON(_ value: Any?) -> DndCharacter.Stat? {
        // Implement the transformation from JSON to your desired type
        if let jsonValue = value as? String {
            // Perform the transformation here
            let context = StatContext(character: character)
            return DndCharacter.Stat(JSONString: jsonValue, context: context )
        }
        return nil
    }
    
    func transformToJSON(_ value: DndCharacter.Stat?) -> String? {
        // Implement the transformation from your desired type to JSON
        if let transformedValue = value {
            // Perform the transformation here
            return transformedValue.toJSONString()
        }
        return nil
    }
}

struct SkillTransformer: TransformType {
    var stat: DndCharacter.Stat
    
    typealias Object = DndCharacter.Skill  // Replace YourType with the desired output type
    
    typealias JSON = String  // Replace JSONValue with the expected input type
    
    
    func transformFromJSON(_ value: Any?) -> DndCharacter.Skill? {
        // Implement the transformation from JSON to your desired type
        if let jsonValue = value as? String {
            // Perform the transformation here
            let context = SkillContext(stat: stat)
            return DndCharacter.Skill(JSONString: jsonValue, context: context )
        }
        return nil
    }
    
    func transformToJSON(_ value: DndCharacter.Skill?) -> String? {
        // Implement the transformation from your desired type to JSON
        if let transformedValue = value {
            // Perform the transformation here
            return transformedValue.toJSONString()
        }
        return nil
    }
}

let transform = TransformOf<Int, String>(fromJSON: { (value: String?) -> Int? in
    // transform value from String? to Int?
    return Int(value!)
}, toJSON: { (value: Int?) -> String? in
    // transform value from Int? to String?
    if let value = value {
        return String(value)
    }
    return nil
})


class DndCharacter: Mappable, ObservableObject {
    var id: UUID = UUID()
    var name: String = ""
    var race: String = ""
    var dndClass: String = ""
    var level: String = ""
    var profileImagePath: String? = ""
    var profileImage: UIImage?
    
    var hp: Int = 0;
    var maxHp: Int = 0;
    var hidDice: String = ""
    var ac: String = ""
    
    var str: Stat!
    var dex: Stat!
    var con: Stat!
    var int: Stat!
    var wis: Stat!
    var cha: Stat!
    
    var speed: Double = 30
    var initiativeBonus: Int = 0
    var passivePerceptionBonus: Int = 0;
    @Published var profBonus: Int = 2;
    
    var acrobatics: Skill!
    var animalHandling: Skill!
    var arcana: Skill!
    var athletics: Skill!
    var deception: Skill!
    var history: Skill!
    var insight: Skill!
    var intimidation: Skill!
    var investigation: Skill!
    var medicine: Skill!
    var nature: Skill!
    var perception: Skill!
    var performance: Skill!
    var persuasion: Skill!
    var religion: Skill!
    var sleigthOfHand: Skill!
    var stealth: Skill!
    var survical: Skill!
    
    
    
    var createdAt: Date = Date()
    var updatedAt: Date = Date()
    
    
    
    required init?(map: ObjectMapper.Map) {
        
    }
    
//    init() {
//        self.str = Stat(character: self)
//        self.dex = Stat(character: self)
//        self.con = Stat(character: self)
//        self.int = Stat(character: self)
//        self.wis = Stat(character: self)
//        self.cha = Stat(character: self)
//        
//        self.str =
//    }
//    
    init(id: UUID = UUID(), name: String, race: String, dndClass: String, level: String = "1", createdAt: Date = Date(), updatedAt: Date = Date()) {
        self.id = id
        self.name = name
        self.race = race
        self.dndClass = dndClass
        self.level = level
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        
        str = Stat()
        dex = Stat()
        con = Stat()
        int = Stat()
        wis = Stat()
        cha = Stat()
        
        acrobatics = Skill()
        animalHandling = Skill()
        arcana = Skill()
        athletics = Skill()
        deception = Skill()
        history = Skill()
        insight = Skill()
        intimidation = Skill()
        investigation = Skill()
        medicine = Skill()
        nature = Skill()
        perception = Skill()
        performance = Skill()
        persuasion = Skill()
        religion = Skill()
        sleigthOfHand = Skill()
        stealth = Skill()
        survical = Skill()
    }
    
    
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        race <- map["race"]
        dndClass <- map["dndClass"]
        level <- map["level"]
        profileImagePath <- map["profileImagePath"]
        createdAt <- map["createdAt"]
        updatedAt <- map["updatedAt"]
        
        speed <- map["speed"]
        initiativeBonus <- map["initiativeBonus"]
        passivePerceptionBonus <- map["passivePerceptionBonus"]
        profBonus <- map["profBonus"]
        
        str <- map["str"]
        dex <- map["dex"]
        con <- map["con"]
        int <- map["int"]
        wis <- map["wis"]
        cha <- map["cha"]
        
        acrobatics <- map["acrobatics"]
        animalHandling <- map["animalHandling"]
        arcana <- map["arcana"]
        athletics <- map["athletics"]
        deception <- map["deception"]
        history <- map["history"]
        insight <- map["insight"]
        intimidation <- map["intimidation"]
        investigation <- map["investigation"]
        medicine <- map["medicine"]
        nature <- map["nature"]
        perception <- map["perception"]
        performance <- map["performance"]
        persuasion <- map["persuasion"]
        religion <- map["religion"]
        sleigthOfHand <- map["sleigthOfHand"]
        stealth <- map["stealth"]
        survical <- map["survical"]
    }
    
        

        
    class Stat: Mappable {
        var value: Int = 10
        var modifier: Int = 0;
        var prof: Bool = true
      
        func mapping(map: ObjectMapper.Map) {
            value <- map["value"]
            modifier <- map["modifier"]
            prof <- map["prof"]
        }
        
        
        init() {
            
        }
        
        required init?(map: ObjectMapper.Map) {
            
        }
        
    }
    

    
    class Skill: Mappable {
        var prof = false
        var exp = false
        var modifier = 0
        
        init() {
            
        }
        
        required init?(map: ObjectMapper.Map) {

        }
        
        func mapping(map: ObjectMapper.Map) {
            prof <- map["prof"]
            exp <- map["exp"]
            modifier <- map["modifier"]
        }
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

