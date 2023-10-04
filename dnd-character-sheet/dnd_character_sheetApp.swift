//
//  dnd_character_sheetApp.swift
//  dnd-character-sheet
//
//  Created by Benaja on 26.09.23.
//

import SwiftUI
import SwiftData

@main
struct dnd_character_sheetApp: App {
//    @StateObject private var store = CharacterStore()
    
    var body: some Scene {
        WindowGroup {
            ExampleSubPage()
//            CharactersOverview()
//                .task {
//                    do {
//                        try await store.loadAll()
//                    } catch {
//                        fatalError(error.localizedDescription)
////                        errorWrapper = ErrorWrapper(error: error,
////                                                    guidance: "Scrumdinger will load sample data and continue.")
//                        
//                    }
//                }
        }
        .modelContainer(for: DndCharacter.self)
//        .environmentObject(store)
    }
}
