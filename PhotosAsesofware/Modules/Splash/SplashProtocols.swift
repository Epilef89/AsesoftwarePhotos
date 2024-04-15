//
//  SplashProtocols.swift
//  Created by David Felipe Cortes Gonzalez on 10/04/24.


protocol SplashViewProtocol: AnyObject {
    var presenter: SplashPresenterProtocol? { get set }
}

protocol SplashPresenterProtocol: AnyObject {
    func animationCompleted()
}

protocol SplashRouterProtocol: AnyObject {
    func routerToHome()
}

protocol SplashInteractorProtocol: AnyObject {
    var presenter: SplashInteractorOutProtocol? { get set }
}

protocol SplashInteractorOutProtocol: AnyObject {
    
}

