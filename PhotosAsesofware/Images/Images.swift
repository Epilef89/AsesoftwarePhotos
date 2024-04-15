//
//  Images.swift
//  PhotosAsesofware
//
//  Created by David Felipe Cortes Gonzalez on 11/04/24.
//

import Foundation
import UIKit

protocol ImageProtocol {
    var image: UIImage? { get }
}

enum Images: String, ImageProtocol {
    case imagePlaceholder
    
    var image: UIImage? {
        return Image(named: self.rawValue)
    }
    
    private func Image(named name: String) -> UIImage? {
        UIImage(named: name, in: .main, compatibleWith: nil)
    }
}
