//
//  HomeProtocols.swift
//  Created by David Felipe Cortes Gonzalez on 10/04/24.


protocol HomeViewProtocol: BaseViewProtocol {
    var presenter: HomePresenterProtocol? { get set }
    func reloadPhotos()
    func showError()
}

protocol HomePresenterProtocol: AnyObject {
    func viewDidLoad()
    func numberOfPhotos() -> Int
    func photo(at index: Int) -> Photo?
    func showPhotoDetail(at index: Int)
}

protocol HomeRouterProtocol: AnyObject {
    func showDetail(photo: Photo)
}

protocol HomeInteractorProtocol: AnyObject {
    var presenter: HomeInteractorOutProtocol? { get set }
    func getPhotos()
}

protocol HomeInteractorOutProtocol: AnyObject {
    func getPhotosError()
    func getPhotosSuccess(_ photos: [Photo])
}

