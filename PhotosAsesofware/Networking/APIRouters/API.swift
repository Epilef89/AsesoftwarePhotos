//
//  API.swift
//  PhotosAsesofware
//
//  Created by David Felipe Cortes Gonzalez on 10/04/24.
//

import Foundation

class API {
    
    private let router: APIRouter
    private let urlBase: URL = URL(string: "https://jsonplaceholder.typicode.com")!
    
    init(router: APIRouter) {
        self.router = router
    }
    
    private func setBasicHeaders(url: inout URLRequest){
        switch router.contentType {
        case .json:
            url.setValue(ContentType.json.rawValue, forHTTPHeaderField: HttpHeaderField.contentType.rawValue)
        }
    }
    
    func asURLRequest() -> URLRequest? {
        var urlRequest:URLRequest
        urlRequest = URLRequest(url: urlBase.appendingPathComponent(router.path))
        urlRequest.httpMethod = router.method.rawValue
        setBasicHeaders(url: &urlRequest)
        return urlRequest
    }

}
