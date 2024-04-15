//
//  SplashRouter.swift
//  Created by David Felipe Cortes Gonzalez on 10/04/24.

import UIKit

final class SplashRouter: SplashRouterProtocol {
    
    // MARK: Private var - let
    private weak var viewController: BaseViewController?
    
    // MARK: Init
    init(viewController: BaseViewController) {
        self.viewController = viewController
    }
    
    // MARK: Public func
    
    func routerToHome() {
        viewController?.navigationController?.setViewControllers([HomeBuilder.build()], animated: false)
    }
    
    // MARK: Private func
    
}

