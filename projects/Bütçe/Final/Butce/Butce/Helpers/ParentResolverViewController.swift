//
//  ParentResolverViewController.swift
//  Butce
//
//  Created by Can Balkaya on 10/10/20.
//

import SwiftUI

class ParentResolverViewController: UIViewController {
    
    // MARK: - Properties
    let onResolve: (UIViewController) -> Void
    
    // MARK: - Life Cycle
    init(onResolve: @escaping (UIViewController) -> Void) {
        self.onResolve = onResolve
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Use init(onResolve:) to instantiate ParentResolverViewController.")
    }
        
    // MARK: - Functions
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        
        if let parent = parent {
            onResolve(parent)
        }
    }
}
