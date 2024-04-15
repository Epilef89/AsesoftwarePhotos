//
//  DetailInteractor.swift
//  Created by David Felipe Cortes Gonzalez on 11/04/24.


final class DetailInteractor: DetailInteractorProtocol {
    
    // MARK: Public var - let
    weak var presenter: DetailInteractorOutProtocol?

    // MARK: Private var - let
    private var networkingPhotosAdapter: NetworkingPhotosAdapterProtocol?

    // MARK: Init
    init(networkingPhotosAdapter: NetworkingPhotosAdapterProtocol = NetworkingPhotosAdapter()) {
        self.networkingPhotosAdapter = networkingPhotosAdapter
    }
    
    // MARK: Public func
    
    func deletePhoto(_ photo: Photo) {
        CoreDataManager.shared.deletePhoto(withId: photo.id)
        networkingPhotosAdapter?.deletePhoto(id: photo.getIdString(), completion: { [weak self] success, error in
            guard let self = self else { return }
            guard success else {
                guard let error = error, error.isNetworkConnectionError else {
                    self.presenter?.deleteFailure()
                    return
                }
                self.presenter?.deletePending()
                return
            }
            self.presenter?.deletedSuccess()
        })
    }
    
    // MARK: Private func
}

