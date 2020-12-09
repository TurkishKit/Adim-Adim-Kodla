//
//  ModalView.swift
//  Butce
//
//  Created by Can Balkaya on 10/20/20.
//

import SwiftUI

struct ModalView<T: View>: UIViewControllerRepresentable {
    
    // MARK: - Properties
    let view: T
    @Binding var isModal: Bool
    let onDismissalAttempt: (()->())?
    
    // MARK: - Functions
    func makeUIViewController(context: Context) -> UIHostingController<T> {
        UIHostingController(rootView: view)
    }
    
    func updateUIViewController(_ uiViewController: UIHostingController<T>, context: Context) {
        uiViewController.parent?.presentationController?.delegate = context.coordinator
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIAdaptivePresentationControllerDelegate {
        let modalView: ModalView
        
        init(_ modalView: ModalView) {
            self.modalView = modalView
        }
        
        func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
            !modalView.isModal
        }
        
        func presentationControllerDidAttemptToDismiss(_ presentationController: UIPresentationController) {
            modalView.onDismissalAttempt?()
        }
    }
}
