//
//  DetailPresenter.swift
//  Created by David Felipe Cortes Gonzalez on 11/04/24.


final class DetailPresenter: DetailPresenterProtocol {
    
    // MARK: Private var - let
    private weak var view: DetailViewProtocol?
    private var router: DetailRouterProtocol
    private var interactor: DetailInteractorProtocol
    private var photo: Photo
    
    // MARK: Init
    init(view: DetailViewProtocol, router: DetailRouterProtocol, interactor: DetailInteractorProtocol, photo: Photo) {
        self.photo = photo
        self.view = view
        self.router = router
        self.interactor = interactor
    }

    // MARK: Public func
    func viewDidLoad() {
        view?.setupView(photo: photo)
    }
    
    func deleteImage() {
        view?.showLoader()
        interactor.deletePhoto(photo)
    }
    
    func retry() {
        deleteImage()
    }
    
    func backToHome() {
        router.backView()
    }

}

// MARK: DetailInteractorOutProtocol
extension DetailPresenter: DetailInteractorOutProtocol {
    func deletedSuccess() {
        view?.hideLoader()
        view?.showConfirmation()
    }
    
    func deleteFailure() {
        view?.hideLoader()
        view?.showErrorMessage()
    }
    
    func deletePending() {
        view?.hideLoader()
        view?.showPendingDeletionMessage()
    }
    
}
