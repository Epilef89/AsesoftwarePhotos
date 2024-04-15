//
//  DetailRouter.swift
//  Created by David Felipe Cortes Gonzalez on 11/04/24.

import UIKit

final class DetailRouter: DetailRouterProtocol {
    
    // MARK: Private var - let
    private weak var viewController: BaseViewController?
    
    // MARK: Init
    init(viewController: BaseViewController) {
        self.viewController = viewController
    }
    
    // MARK: Public func
    func backView() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    // MARK: Private func
    
}

