//
//  APIPhotosRouter.swift
//  Created by David Felipe Cortes Gonzalez on 10/04/24.

import Foundation


enum APIPhotosRouter: APIRouter {

    case getPhotos
    case deletePhoto(id: String)
    
    var method: HTTPMethod {
        switch self {
        case .getPhotos:
            return .get
        case .deletePhoto:
            return .delete
        }
    }
    
    var path: String {
        let baseURL: String = "/photos"
        switch self {
        case .getPhotos:
            return baseURL
        case .deletePhoto(let id):
            return baseURL + "/" + (id)
        }
    }
    
    var contentType: ContentType {
        return .json
    }
    
}

