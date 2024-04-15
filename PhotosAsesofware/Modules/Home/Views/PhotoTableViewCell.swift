//
//  PhotoTableViewCell.swift
//  PhotosAsesofware
//
//  Created by David Felipe Cortes Gonzalez on 11/04/24.
//

import UIKit
import SDWebImage
import PureLayout


class PhotoTableViewCell: UITableViewCell {
    
    static let identifier: String = "PhotoTableViewCell"
    
    // MARK: Private var -let
    private let constraintMultiplier: CGFloat = 1
    private let imageViewHeight: CGFloat = 80
    private let imageViewWidth: CGFloat = 80
    private let titleFont: UIFont = UIFont.systemFont(ofSize: 16)
    private let titleTextColor: UIColor = UIColor.blue
    private let contentFont: UIFont = UIFont.systemFont(ofSize: 14)
    private let contentTextColor: UIColor = UIColor.gray
    private let photoImageMargin: UIEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    private let contentMargin: UIEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    private let labelMargin: UIEdgeInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.contentMode = .scaleAspectFit
        imageView.autoSetDimensions(to: CGSize(width: 80, height: 80))
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Home.CellDetail.title
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = titleFont
        label.textColor = titleTextColor
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var titleDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = contentFont
        label.textColor = UIColor.gray
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var albumIdLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Home.CellDetail.albumTitle
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = titleFont
        label.textColor = titleTextColor
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var albumIdDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = contentFont
        label.textColor = contentTextColor
        label.numberOfLines = .zero
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCellWith(model: Photo) {
        selectionStyle = .none
        contentView.layer.masksToBounds = true
        addImageView(model)
        addTitle(model.title)
        addAlbumId(model.albumId)
    }
    
    // MARK: Private func
    private func addImageView(_ model: Photo) {
        photoImageView.removeFromSuperview()
        contentView.addSubview(photoImageView)
        if let image = model.getImage() {
            photoImageView.image = image
        } else {
            if let url = URL(string: model.url) {
                photoImageView.sd_setImage(with: url, placeholderImage: Images.imagePlaceholder.image)
            } else {
                photoImageView.image = Images.imagePlaceholder.image
            }
        }
        photoImageView.autoPinEdge(toSuperviewEdge: .left, withInset: photoImageMargin.left)
        photoImageView.autoAlignAxis(toSuperviewAxis: .horizontal)
        photoImageView.autoPinEdge(toSuperviewEdge: .top, withInset: photoImageMargin.top, relation: .greaterThanOrEqual)
        photoImageView.autoPinEdge(toSuperviewEdge: .bottom, withInset: photoImageMargin.bottom, relation: .greaterThanOrEqual)
    }
    
    private func addTitle(_ title: String) {
        contentView.addSubview(titleLabel)
        titleLabel.autoPinEdge(.left, to: .right, of: photoImageView, withOffset: labelMargin.left)
        titleLabel.autoPinEdge(toSuperviewEdge: .top, withInset: contentMargin.top, relation: .greaterThanOrEqual)
        titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: contentMargin.right)
        contentView.addSubview(titleDescriptionLabel)
        titleDescriptionLabel.text = title
        titleDescriptionLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: labelMargin.bottom)
        titleDescriptionLabel.autoPinEdge(.left, to: .left, of: titleLabel)
        titleDescriptionLabel.autoPinEdge(.right, to: .right, of: titleLabel)
        titleDescriptionLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: contentMargin.bottom, relation: .greaterThanOrEqual)
    }
    
    private func addAlbumId(_ albumId: Int64) {
        contentView.addSubview(albumIdLabel)
        albumIdLabel.autoPinEdge(.top, to: .bottom, of: titleDescriptionLabel, withOffset: labelMargin.top)
        albumIdLabel.autoPinEdge(.left, to: .left, of: titleLabel)
        albumIdLabel.autoPinEdge(.right, to: .right, of: titleLabel)
        contentView.addSubview(albumIdDescriptionLabel)
        albumIdDescriptionLabel.text = String(albumId)
        albumIdDescriptionLabel.autoPinEdge(.top, to: .bottom, of: albumIdLabel, withOffset: labelMargin.top)
        albumIdDescriptionLabel.autoPinEdge(.left, to: .left, of: albumIdLabel)
        albumIdDescriptionLabel.autoPinEdge(.right, to: .right, of: albumIdLabel)
        albumIdDescriptionLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: contentMargin.bottom, relation: .greaterThanOrEqual)
    }
    
}
