//
//  APIRouter.swift
//  PhotosAsesofware
//
//  Created by David Felipe Cortes Gonzalez on 10/04/24.
//

import Foundation

protocol APIRouter {
    var method: HTTPMethod { get }
    var path: String { get }
    var contentType: ContentType { get }
}

enum HTTPMethod: String {
    case get     = "GET"
    case delete  = "DELETE"
}

enum ContentType: String {
    case json = "application/json"
}

enum HttpHeaderField: String {
    case contentType = "Content-Type"
}
