//
//  HomeBuilder.swift
//  Created by David Felipe Cortes Gonzalez on 10/04/24.


final class HomeBuilder {
    
    static func build() -> HomeViewController {
        let viewController = HomeViewController()
        let router =  HomeRouter(viewController: viewController)
        let interactor = HomeInteractor()
        let presenter: HomePresenterProtocol & HomeInteractorOutProtocol = HomePresenter(view: viewController, router: router, interactor: interactor)
        interactor.presenter = presenter
        viewController.presenter = presenter
        return viewController
    }
}
