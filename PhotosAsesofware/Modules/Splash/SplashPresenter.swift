//
//  SplashPresenter.swift
//  Created by David Felipe Cortes Gonzalez on 10/04/24.


final class SplashPresenter: SplashPresenterProtocol {
    
    // MARK: Private var - let
    private weak var view: SplashViewProtocol?
    private var router: SplashRouterProtocol
    private var interactor: SplashInteractorProtocol
    
    // MARK: Init
    init(view: SplashViewProtocol, router: SplashRouterProtocol, interactor: SplashInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }

    // MARK: Public func
    func animationCompleted() {
        router.routerToHome()
    }
    
    // MARK: Private func

}

// MARK: SplashInteractorOutProtocol
extension SplashPresenter: SplashInteractorOutProtocol {
    
}
