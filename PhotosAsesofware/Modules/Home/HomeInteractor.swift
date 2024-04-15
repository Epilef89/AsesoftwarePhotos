//
//  HomeInteractor.swift
//  Created by David Felipe Cortes Gonzalez on 10/04/24.
import SDWebImage

final class HomeInteractor: HomeInteractorProtocol {
    
    // MARK: Public var - let
    weak var presenter: HomeInteractorOutProtocol?

    // MARK: Private var - let
    private var networkingHomeAdapter: NetworkingPhotosAdapterProtocol

    // MARK: Init
    init(networkingHomeAdapter: NetworkingPhotosAdapterProtocol = NetworkingPhotosAdapter()) {
        self.networkingHomeAdapter = networkingHomeAdapter
    }
    
    // MARK: Public func
    func getPhotos() {
        networkingHomeAdapter.getPhotos { [weak self] photos, error in
            guard let self = self else { return }
            guard let photos = photos else {
                self.presenter?.getPhotosError()
                return
            }
            self.presenter?.getPhotosSuccess(photos)
        }
    }
    
    // MARK: Private func
}

