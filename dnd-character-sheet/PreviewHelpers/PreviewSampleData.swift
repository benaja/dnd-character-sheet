//
//  PreviewSampleData.swift
//  dnd-character-sheet
//
//  Created by Benaja on 30.09.2023.
//

import Foundation
import SwiftData

let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(for: DndCharacter.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        
        return container
    } catch {
        fatalError("Failend to load preview container")
    }
}()
