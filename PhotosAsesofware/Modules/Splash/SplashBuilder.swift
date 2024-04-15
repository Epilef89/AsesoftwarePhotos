//
//  SplashBuilder.swift
//  Created by David Felipe Cortes Gonzalez on 10/04/24.


final class SplashBuilder {
    
    static func build() -> SplashViewController {
        let viewController = SplashViewController()
        let router =  SplashRouter(viewController: viewController)
        let interactor = SplashInteractor()
        let presenter: SplashPresenterProtocol & SplashInteractorOutProtocol = SplashPresenter(view: viewController, router: router, interactor: interactor)
        interactor.presenter = presenter
        viewController.presenter = presenter
        return viewController
    }
}
