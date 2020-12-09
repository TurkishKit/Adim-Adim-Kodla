//
//  FileManager+Ext.swift
//  Butce
//
//  Created by Can Balkaya on 10/14/20.
//

import Foundation

extension FileManager {
    
    // MARK: - Properties
    static var appIdentifier: String {
        return "group.com.turkishkit.Butce"
    }
    
    // MARK: Functions
    static func sharedContainerURL() -> URL {
        return FileManager.default.containerURL(
            forSecurityApplicationGroupIdentifier: appIdentifier
        )!
    }
}
