//
//  NSError+Extension.swift
//  PhotosAsesofware
//
//  Created by David Felipe Cortes Gonzalez on 10/04/24.
//

import Foundation

extension NSError {
    var isNetworkConnectionError: Bool {
        let networkErrors = [NSURLErrorNetworkConnectionLost, NSURLErrorNotConnectedToInternet]
        return domain == NSURLErrorDomain && networkErrors.contains(code)
    }
}
