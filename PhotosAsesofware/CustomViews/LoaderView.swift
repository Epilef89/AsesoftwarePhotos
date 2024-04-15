//
//  LoaderView.swift
//  PhotosAsesofware
//
//  Created by David Felipe Cortes Gonzalez on 10/04/24.
//

import Foundation
import UIKit

class LoaderView: UIView {
    
    private let loaderSize: CGSize = CGSize(width: 300, height: 300)
    private let multiplierConstraintConstant: CGFloat = 1
    private let backgorundAlpha: CGFloat = 0.2
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.black.withAlphaComponent(backgorundAlpha)
        let animation = LottieManager.loader.animationView
        addSubview(animation)
        animation.centerInSuperview()
        let widthConstraint = NSLayoutConstraint(item: animation,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .notAnAttribute,
                                                 multiplier: multiplierConstraintConstant,
                                                 constant: loaderSize.width)

        let heightConstraint = NSLayoutConstraint(item: animation,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: multiplierConstraintConstant,
                                                  constant: loaderSize.height)
        NSLayoutConstraint.activate([widthConstraint, heightConstraint])
        animation.loopMode = .loop
        animation.play()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
