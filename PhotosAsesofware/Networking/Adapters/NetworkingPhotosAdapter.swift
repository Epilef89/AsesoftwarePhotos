//
//  NetworkingPhotosAdapter.swift
//  Created by David Felipe Cortes Gonzalez on 10/04/24.

import Foundation
import SDWebImage


protocol NetworkingPhotosAdapterProtocol {
    func getPhotos(completion: @escaping ([Photo]?, NSError?) -> Void)
    func deletePhoto(id: String, completion: @escaping (_ success: Bool, _ error: NSError?) -> Void)
}

final class NetworkingPhotosAdapter: NetworkingPhotosAdapterProtocol {
    
    // MARK: Private var - let
    
    // MARK: Init
    
    // MARK: Public func
    func getPhotos(completion: @escaping ([Photo]?, NSError?) -> Void) {
        NetworkManager.request(router: APIPhotosRouter.getPhotos, responseOfType: [Photo].self) { [weak self] response, result in
            switch result {
            case .success(let photos):
                DispatchQueue.global().async {
                    self?.saveInCoreData(photos: photos)
                }
                completion(photos, nil)
            case .failure(let error):
                guard let error = error , error.isNetworkConnectionError else {
                    completion(nil, error)
                    return
                }
                DispatchQueue.main.async {
                    let myPhotos = CoreDataManager.shared.getFotos()
                    completion(myPhotos, nil)
                }
            }
        }
    }
    
    func deletePhoto(id: String, completion: @escaping (_ success: Bool, _ error: NSError?) -> Void) {
        NetworkManager.request(router: APIPhotosRouter.deletePhoto(id: id), withBackRest: true) { response, result in
            switch result {
            case .success:
                completion(true, nil)
            case .failure(let error):
                completion(false, error)
            }
        }
    }

    // MARK: Private func
    
    private func saveInCoreData(photos: [Photo]) {
        for photo in photos {
            CoreDataManager.shared.save(photo: photo)
        }
    }
}

