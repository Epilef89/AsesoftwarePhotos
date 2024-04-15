//
//  SplashViewController.swift
//  Created by David Felipe Cortes Gonzalez on 10/04/24.

import UIKit
import Lottie

final class SplashViewController: BaseViewController {
    
    // MARK: var - let
    var presenter: SplashPresenterProtocol?
    
    // MARK: Private var -let
    private lazy var animationView: LottieAnimationView = {
        let animation = LottieManager.splash.animationView
        return animation
    }()
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: Private func
    
    private func setupView() {
        view.addSubview(animationView)
        animationView.centerInSuperview()
        animationView.play { [weak self] completed in
            guard let self = self else { return }
            self.presenter?.animationCompleted()
        }
    }
}

// MARK: SplashViewProtocol
extension SplashViewController: SplashViewProtocol {
    
}
