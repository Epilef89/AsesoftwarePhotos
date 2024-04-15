//
//  UIView+Extension.swift
//  PhotosAsesofware
//
//  Created by David Felipe Cortes Gonzalez on 10/04/24.
//

import Foundation
import UIKit

extension UIView {
    func centerInSuperview() {
        guard let superview = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: superview.centerXAnchor),
            centerYAnchor.constraint(equalTo: superview.centerYAnchor)
        ])
    }
}
