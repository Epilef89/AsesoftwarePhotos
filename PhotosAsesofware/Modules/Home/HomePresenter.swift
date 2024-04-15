//
//  HomePresenter.swift
//  Created by David Felipe Cortes Gonzalez on 10/04/24.

import Foundation

final class HomePresenter: HomePresenterProtocol {
    
    // MARK: Private var - let
    private weak var view: HomeViewProtocol?
    private var router: HomeRouterProtocol
    private var interactor: HomeInteractorProtocol
    private var photos: [Photo] = []
    
    // MARK: Init
    init(view: HomeViewProtocol, router: HomeRouterProtocol, interactor: HomeInteractorProtocol) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }

    // MARK: Public func
    func viewDidLoad() {
        view?.showLoader()
        interactor.getPhotos()
    }
    
    func numberOfPhotos() -> Int {
        return photos.count
    }
    
    func photo(at index: Int) -> Photo? {
        guard checkIndex(index) else { return nil }
        return Photo(albumId: photos[index].albumId, id: photos[index].id, title: photos[index].title, url: photos[index].url, thumbnailUrl: photos[index].thumbnailUrl, image: photos[index].image)
    }
    
    func showPhotoDetail(at index: Int) {
        guard checkIndex(index) else { return }
        router.showDetail(photo: photos[index])
    }
    
    // MARK: Private func
    
    private func checkIndex(_ index: Int) -> Bool {
        return index >= .zero && index < photos.count
    }

}

// MARK: HomeInteractorOutProtocol
extension HomePresenter: HomeInteractorOutProtocol {
    func getPhotosError() {
        view?.hideLoader()
        view?.showError()
    }
    
    func getPhotosSuccess(_ photos: [Photo]) {
        self.photos = photos
        view?.hideLoader()
        view?.reloadPhotos()
    }
    
}
