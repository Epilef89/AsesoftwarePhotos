//
//  Photo.swift
//  PhotosAsesofware
//
//  Created by David Felipe Cortes Gonzalez on 12/04/24.
//

import Foundation
import UIKit
import SDWebImage

class Photo: Codable {
    var albumId: Int64
    var id: Int64
    var title: String
    var url: String
    var thumbnailUrl: String
    var image: Data?
    
    init(albumId: Int64, id: Int64, title: String, url: String, thumbnailUrl: String, image: Data?) {
        self.albumId = albumId
        self.id = id
        self.title = title
        self.url = url
        self.thumbnailUrl = thumbnailUrl
        self.image = image
    }
    
    func getImage() -> UIImage? {
        guard let image = image else {
            guard let storageImage = CoreDataManager.shared.getPhoto(id: id) else {
                return nil
            }
            image = storageImage
            return UIImage(data: storageImage)
        }
        return UIImage(data: image)
    }
    
    func getImageView() -> UIImageView {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        guard let image = getImage() else {
            if let url = URL(string: url) {
                imageView.sd_setImage(with: url, placeholderImage: Images.imagePlaceholder.image)
            } else {
                imageView.image = Images.imagePlaceholder.image
            }
            return imageView
        }
        imageView.image = image
        return imageView
    }
    
    func getAlbumString() -> String {
        return String(albumId)
    }
    
    func getIdString() -> String {
        return String(id)
    }
    
}

extension Photo: Equatable {
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id && lhs.albumId == rhs.albumId
    }
}
