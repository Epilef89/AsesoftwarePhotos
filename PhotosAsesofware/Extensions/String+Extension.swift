//
//  String+Extension.swift
//  PhotosAsesofware
//
//  Created by David Felipe Cortes Gonzalez on 11/04/24.
//

import Foundation

extension String {
    var localizable: String {
        NSLocalizedString(self, bundle: .main, comment: "")
    }
}
