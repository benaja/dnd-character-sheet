//
//  DndCharacter.swift
//  dnd-character-sheet
//
//  Created by Benaja on 26.09.23.
//

import SwiftUI
import PhotosUI
import CoreTransferable


class DndCharacter: Identifiable, ObservableObject {
    @Published var id: UUID
    @Published var name: String
    @Published var race: String
    @Published var dndClass: String
    @Published var level: Int
    
    enum ImageState {
        case empty
        case loading(Progress)
        case success(Image)
        case failure(Error)
    }
    
    enum TransferError: Error {
        case importFailed
    }

    
    struct ProfileImage: Transferable {
        let image: Image
        
        static var transferRepresentation: some TransferRepresentation {
            DataRepresentation(importedContentType: .image) { data in
            #if canImport(AppKit)
                guard let nsImage = NSImage(data: data) else {
                    throw TransferError.importFailed
                }
                let image = Image(nsImage: nsImage)
                return ProfileImage(image: image)
            #elseif canImport(UIKit)
                guard let uiImage = UIImage(data: data) else {
                    throw TransferError.importFailed
                }
                let image = Image(uiImage: uiImage)
                return ProfileImage(image: image)
            #else
                    throw TransferError.importFailed
            #endif
            }
        }
    }

    
    init(id: UUID = UUID(), name: String, race: String, dndClass: String, level: Int = 1) {
        self.id = id
        self.name = name
        self.race = race
        self.dndClass = dndClass
        self.level = level
    }
    
    static var emptyCharacter: DndCharacter {
        DndCharacter(name: "", race: "", dndClass: "", level: 1)
    }
    
    @Published private(set) var imageState: ImageState = .empty
    
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            if let imageSelection {
                let progress = loadTransferable(from: imageSelection)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: ProfileImage.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else {
                    print("Failed to get the selected item.")
                    return
                }
                switch result {
                case .success(let profileImage?):
                    self.imageState = .success(profileImage.image)
                case .success(nil):
                    self.imageState = .empty
                case .failure(let error):
                    self.imageState = .failure(error)
                }
            }
        }
    }
}

extension DndCharacter {
    static let sampleData: [DndCharacter] =
    [
        DndCharacter(name: "Val", race: "Elf", dndClass: "Barbarien", level: 1),
        DndCharacter(name: "Milo", race: "Halfling", dndClass: "Fihter", level: 3),
        DndCharacter(name: "Halgur", race: "Orc", dndClass: "Wizard", level: 8),
    ]
}

