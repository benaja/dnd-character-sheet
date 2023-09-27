//
//  ScrumStore.swift
//  Scrumdinger
//
//  Created by Benaja on 26.09.23.
//

import SwiftUI

@MainActor
class CharacterStore: ObservableObject {
    @Published var characters: [DndCharacter] = []
    

    
    private static func fileURL(_ id: String? = nil) throws -> URL {
        var path = try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: true)
        .appendingPathComponent("characters")
        
        if let id = id {
            path = path.appendingPathComponent(id)
        }
        
        try FileManager.default.createDirectory(atPath: path.path, withIntermediateDirectories: true, attributes: nil)
        return path
    }
    
    func loadAll() async throws {
        let task = Task<[DndCharacter], Error> {
            let fm = FileManager.default
            let directoryUrl = try Self.fileURL()
            var dndCharacters: [DndCharacter] = []
            
            do {
                let folders = try fm.contentsOfDirectory(at: directoryUrl, includingPropertiesForKeys: [], options: [
                    FileManager.DirectoryEnumerationOptions.skipsHiddenFiles])
                
                for folder in folders {
                    let characterDataPath = folder.appendingPathComponent("data.json")
                    guard let data = try? Data(contentsOf: characterDataPath) else {
                        continue
                    }
                    
                    let dndCharacter = try JSONDecoder().decode(DndCharacter.self, from: data)
                    dndCharacters.append(dndCharacter)

                }
            } catch {
                fatalError(error.localizedDescription)
                // failed to read directory – bad permissions, perhaps?
            }

            
            return dndCharacters
        }
        let characters = try await task.value
        self.characters = characters
    }
    
    func save(character: DndCharacter) async throws {
        let task = Task {
            let basePath = try Self.fileURL(character.id.uuidString)
            if let profileImage = character.profileImage {
                saveImge(profileImage, basePath.appendingPathComponent("profileImage.jpg"))
            }
            let data = try JSONEncoder().encode(character)
            let outfile = basePath.appendingPathComponent("data.json")
            try data.write(to: outfile)
        }
        
        _ = try await task.value
    }
    
    func saveImge(_ image: UIImage, _ path: URL) {
        if let data = image.jpegData(compressionQuality: 1.0) {
            try? data.write(to: path)
        }
    }
}
