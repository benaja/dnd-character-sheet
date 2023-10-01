//
//  PreviewSampleData.swift
//  dnd-character-sheet
//
//  Created by Benaja on 30.09.2023.
//

import Foundation
import SwiftData

func previewContainer() -> ModelContainer {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: DndCharacter.self, configurations: config)
    
    return container

    
//    do {
//            } catch {
//        fatalError("Failend to load preview container")
//    }
}


