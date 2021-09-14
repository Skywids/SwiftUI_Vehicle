//
//  ImagePicker.swift
//  DrivingDemo
//
//  Created by Vishal on 10/05/21.
//

import Foundation
import SwiftUI

//struct ImagePicker: UIViewControllerRepresentable {
//
//    @Binding var isShown: Bool
//    @Binding var uiImage: UIImage?
//
//    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//
//        @Binding var isShown: Bool
//        @Binding var uiImage: UIImage?
//
//        init(isShown: Binding<Bool>, uiImage: Binding<UIImage?>) {
//            _isShown = isShown
//            _uiImage = uiImage
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController,
//                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            let imagePicked = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//            uiImage = imagePicked
//            isShown = false
//        }
//
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            isShown = false
//        }
//
//    }
//
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(isShown: $isShown, uiImage: $uiImage)
//    }
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController,
//                                context: UIViewControllerRepresentableContext<ImagePicker>) {
//
//    }
//
//}


struct ImagePicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode)
    private var presentationMode

    let sourceType: UIImagePickerController.SourceType
//    let onImagePicked: (UIImage) -> Void
    @Binding var uiImage: UIImage?

    final class Coordinator: NSObject,
    UINavigationControllerDelegate,
    UIImagePickerControllerDelegate {

        @Binding
        private var presentationMode: PresentationMode
        private let sourceType: UIImagePickerController.SourceType
//        private let onImagePicked: (UIImage) -> Void
        
        @Binding var uiImage: UIImage?

        init(presentationMode: Binding<PresentationMode>,
             sourceType: UIImagePickerController.SourceType,
//             onImagePicked: @escaping (UIImage) -> Void,
             uiImage: Binding<UIImage?>) {
            _presentationMode = presentationMode
            self.sourceType = sourceType
//            self.onImagePicked = onImagePicked
            _uiImage = uiImage
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let uiImage1 = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
//            onImagePicked(uiImage1)
            uiImage = uiImage1
            presentationMode.dismiss()

        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode,
                           sourceType: sourceType,
//                           onImagePicked: onImagePicked,
                           uiImage: $uiImage)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

}
