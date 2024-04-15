//
//  HomeRouter.swift
//  Created by David Felipe Cortes Gonzalez on 10/04/24.

import UIKit

final class HomeRouter: HomeRouterProtocol {
    
    // MARK: Private var - let
    private weak var viewController: BaseViewController?
    
    // MARK: Init
    init(viewController: BaseViewController) {
        self.viewController = viewController
    }
    
    // MARK: Public func
    
    func showDetail(photo: Photo) {
        let detailViewController = DetailBuilder.build(photo: photo)
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    // MARK: Private func
    
}

