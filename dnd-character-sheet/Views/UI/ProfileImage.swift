/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The profile image that reflects the selected item state.
*/

import SwiftUI
import PhotosUI
import CoreTransferable



enum ImageState {
    case empty
    case loading(Progress)
    case success(Image)
    case failure(Error)
}

struct ProfileImage: View {
    
	let imageState: ImageState
	
	var body: some View {
		switch imageState {
		case .success(let image):
			image.resizable()
		case .loading:
			ProgressView()
		case .empty:
			Image(systemName: "person.fill")
				.font(.system(size: 40))
				.foregroundColor(.white)
		case .failure:
			Image(systemName: "exclamationmark.triangle.fill")
				.font(.system(size: 40))
				.foregroundColor(.white)
		}
	}
}

struct CircularProfileImage: View {
	let imageState: ImageState
	
	var body: some View {
		ProfileImage(imageState: imageState)
            .scaledToFill()
			.clipShape(Circle())
			.frame(width: 100, height: 100)
			.background {
				Circle().fill(
					LinearGradient(
						colors: [.yellow, .orange],
						startPoint: .top,
						endPoint: .bottom
					)
				)
			}
	}
}

struct EditableCircularProfileImage: View {
    @Binding var imagePath: String?
    lazy var image: UIImage? = {
        imageByPath()
    }()
//    @Binding var image: UIImage?
    @State var imageState = ImageState.empty
    @State var imageSelection: PhotosPickerItem? = nil {
        didSet {
            if let imageSelection {
                let progress = loadTransferable(from: imageSelection)
                imageState = .loading(progress)
            } else {
                imageState = .empty
            }
        }
    }
    
    func imageByPath() -> UIImage? {
        guard self.imagePath != nil else {
            return nil
        }
        do {
            let path = try Self.imagePath().appendingPathComponent(self.imagePath!)
            let imageData = try Data(contentsOf: path)
            return UIImage(data: imageData)
        } catch {
            fatalError(error.localizedDescription)
        }

    }
    
    init(imagePath: Binding<String?>) {
        self._imagePath = imagePath
        if let image = image {
            let image = Image(uiImage: image)
            _imageState = State(wrappedValue:.success(image))
        }
    }
    
    enum TransferError: Error {
        case importFailed
    }
    
    struct ProfileImage: Transferable {
        let image: Image
        let uiImage: UIImage
        
        static var transferRepresentation: some TransferRepresentation {
            DataRepresentation(importedContentType: .image) { data in
                guard let uiImage = UIImage(data: data) else {
                    throw TransferError.importFailed
                }
                let image = Image(uiImage: uiImage)
                return ProfileImage(image: image, uiImage: uiImage)
            }
        }
    }

	
	var body: some View {
		CircularProfileImage(imageState: imageState)
			.overlay(alignment: .bottomTrailing) {
				PhotosPicker(selection: Binding(get: {imageSelection}, set: {imageSelection = $0}),
							 matching: .images,
							 photoLibrary: .shared()) {
					Image(systemName: "pencil.circle.fill")
						.symbolRenderingMode(.multicolor)
						.font(.system(size: 30))
						.foregroundColor(.accentColor)
				}
				.buttonStyle(.borderless)
			}
	}
    
    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: ProfileImage.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else {
                    print("Failed to get the selected item.")
                    return
                }
                switch result {
                case .success(let profileImage?):
//                    self.image = profileImage.uiImage
                    self.imageState = .success(profileImage.image)
                    if let data = profileImage.uiImage.jpegData(compressionQuality: 1.0) {
                        let imageName = "\(UUID().uuidString).jpg"
                        let path = try? Self.imagePath().appendingPathComponent(imageName)
                        guard path != nil else {
                            return
                        }
                        do {
                            try data.write(to: path!)
                            self.imagePath = imageName
                            print(imagePath ?? "")
                        } catch {
                            fatalError(error.localizedDescription)
                        }
                    }
                case .success(nil):
                    self.imageState = .empty
                case .failure(let error):
                    self.imageState = .failure(error)
                }
            }
        }
    }
    
    private static func imagePath() throws -> URL {
        let path = try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: true)
                .appendingPathComponent("images")
        
        try FileManager.default.createDirectory(atPath: path.path, withIntermediateDirectories: true, attributes: nil)
        return path;
    }
}
