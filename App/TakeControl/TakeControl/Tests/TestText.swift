//
//  TestText.swift
//  TakeControl
//
//  Created by Blaž Bergant on 13/05/2023.
//

import SwiftUI

struct TestText: View {
    @State private var isImagePickerDisplayed = false
    @State private var selectedImage: UIImage?

    var body: some View {
        VStack {
            if let image = selectedImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }

            Button(action: {
                self.isImagePickerDisplayed = true
            }) {
                Text("Select Image")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(15)
            }
        }
        .sheet(isPresented: $isImagePickerDisplayed) {
            ImagePickerView(selectedImage: self.$selectedImage, isDisplayed: self.$isImagePickerDisplayed)
        }
    }
}

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var isDisplayed: Bool

    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIImagePickerController()
        controller.delegate = context.coordinator
        return controller
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePickerView

        init(parent: ImagePickerView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = uiImage
            }
            parent.isDisplayed = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isDisplayed = false
        }
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}


struct TestText_Previews: PreviewProvider {
    static var previews: some View {
        TestText()
    }
}
