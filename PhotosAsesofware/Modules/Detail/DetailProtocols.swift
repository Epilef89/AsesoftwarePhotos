//
//  DetailProtocols.swift
//  Created by David Felipe Cortes Gonzalez on 11/04/24.


protocol DetailViewProtocol: BaseViewProtocol {
    var presenter: DetailPresenterProtocol? { get set }
    func setupView(photo: Photo)
    func showErrorMessage()
    func showPendingDeletionMessage()
    func showConfirmation()
}

protocol DetailPresenterProtocol: AnyObject {
    func viewDidLoad()
    func deleteImage()
    func retry()
    func backToHome()
}

protocol DetailRouterProtocol: AnyObject {
    func backView()
}

protocol DetailInteractorProtocol: AnyObject {
    var presenter: DetailInteractorOutProtocol? { get set }
    func deletePhoto(_ photo: Photo)
}

protocol DetailInteractorOutProtocol: AnyObject {
    func deletedSuccess()
    func deleteFailure()
    func deletePending()
}

