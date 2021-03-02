//
//  StringExtension.swift
//  WorldBeersAM
//
//  Created by Aleksandr Milashevski on 01/03/21.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
