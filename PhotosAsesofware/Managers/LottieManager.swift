//
//  LottieManager.swift
//  PhotosAsesofware
//
//  Created by David Felipe Cortes Gonzalez on 10/04/24.
//

import Foundation
import Lottie
import UIKit

protocol LottieProtocol {
    var animationView: LottieAnimationView { get }
}

enum LottieManager: String, LottieProtocol {
    
    case splash
    case loader
    case internetConnection
    
    var animationView: LottieAnimationView {
        let animation = LottieAnimationView(asset: self.rawValue)
        animation.contentMode = .scaleAspectFit
        animation.translatesAutoresizingMaskIntoConstraints = false
        return animation
    }
}
