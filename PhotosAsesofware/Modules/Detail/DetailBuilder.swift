//
//  DetailBuilder.swift
//  Created by David Felipe Cortes Gonzalez on 11/04/24.


final class DetailBuilder {
    
    static func build(photo: Photo) -> DetailViewController {
        let viewController = DetailViewController()
        let router =  DetailRouter(viewController: viewController)
        let interactor = DetailInteractor()
        let presenter: DetailPresenterProtocol & DetailInteractorOutProtocol = DetailPresenter(view: viewController, router: router, interactor: interactor, photo: photo)
        interactor.presenter = presenter
        viewController.presenter = presenter
        return viewController
    }
}
