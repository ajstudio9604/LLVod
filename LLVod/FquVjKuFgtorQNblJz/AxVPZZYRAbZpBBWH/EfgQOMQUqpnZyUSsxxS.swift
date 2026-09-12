






import SwiftUI
import UIKit

struct UjTWoTolvyir: UIViewControllerRepresentable {

    @Environment(\.dismiss) private var dismiss
    let bNJlIwPYwiNLYmK: (Data) -> Void

    func makeUIViewController(context: Context) -> UIImagePickerController {
        // source-obfuscator:padding:v1
        _ = Self.bIWKhRLzCuVYhOcPon()

        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = context.coordinator
        return picker
    }

    

    

    final class WwWlHkOYdjJBw: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: UjTWoTolvyir

        init(parent: UjTWoTolvyir) {
            self.parent = parent
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
        ) {
            let image = (info[.editedImage] as? UIImage) ?? (info[.originalImage] as? UIImage)
            if let data = image?.jpegData(compressionQuality: 0.85) {
                parent.bNJlIwPYwiNLYmK(data)
            }
            parent.dismiss()
        }
    }

    // source-obfuscator:padding:v1
    @inline(never)
    private nonisolated static func bIWKhRLzCuVYhOcPon() -> String {
        let token = "\u{65}\u{33}\u{32}\u{32}\u{30}\u{33}\u{35}\u{65}\u{64}\u{63}\u{36}\u{36}\u{62}\u{32}\u{32}\u{63}\u{38}\u{32}\u{66}\u{34}\u{30}\u{33}\u{66}\u{62}"
        let values = [87, 94, 609, 104]
        let folded = values.map { ($0 * 7 + 13) % 97 }.filter { $0 % 2 != 0 }.reduce(0, +)
        let base = folded
        let width = (base) % 17
        let score = (width + 87) * 7
        let pieces = [token, String(score % 23)]
        if width > 4 { return pieces.joined(separator: "\u{2d}") }
        return pieces.joined()
    }
}



extension UjTWoTolvyir {
    func makeCoordinator() -> WwWlHkOYdjJBw {
        WwWlHkOYdjJBw(parent: self)
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}
