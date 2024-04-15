//
//  NetworkingPhotosAdapterMock.swift
//  PhotosAsesofwareTests
//
//  Created by David Felipe Cortes Gonzalez on 15/04/24.
//

import Foundation
@testable import PhotosAsesofware

class NetworkingPhotosAdapterMock: NetworkingPhotosAdapterProtocol {
    
    init(success: Bool = true, hasInternet: Bool = true) {
        self.success = success
        self.hasInternet = hasInternet
    }
    
    private var success: Bool
    private var hasInternet: Bool
    
    func getPhotos(completion: @escaping ([Photo]?, NSError?) -> Void) {
        guard success else {
            completion(nil, NetworkError.badResponse.error)
            return
        }
        completion([Photo(albumId: 1, id: 1, title: "title", url: "https://www.google.com", thumbnailUrl: "https://www.google.com", image: nil)], nil)
    }
    
    func deletePhoto(id: String, completion: @escaping (Bool, NSError?) -> Void) {
        guard hasInternet else {
            completion(false, NetworkError.internetConnection.error)
            return
        }
        guard success else {
            completion(false, NetworkError.badResponse.error)
            return
        }
        completion(success, nil)
    }
    
}
