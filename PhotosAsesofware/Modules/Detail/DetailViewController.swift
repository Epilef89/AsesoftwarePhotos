//
//  DetailViewController.swift
//  Created by David Felipe Cortes Gonzalez on 11/04/24.

import UIKit

final class DetailViewController: BaseViewController {
    
    // MARK: var - let
    var presenter: DetailPresenterProtocol?
    
    // MARK: Private var -let
    private let titleFont: UIFont = UIFont.systemFont(ofSize: 16)
    private let titleTextColor: UIColor = UIColor.blue
    private let contentFont: UIFont = UIFont.systemFont(ofSize: 14)
    private let contentTextColor: UIColor = UIColor.gray
    private let sizeImageFactor: CGFloat = 0.6
    private var imageView: UIImageView?
    private let titleMargin: UIEdgeInsets = UIEdgeInsets(top: 24, left: 16, bottom: 4, right: 16)
    private let albumMargin: UIEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 4, right: 16)
    private let buttonMargin: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0)
    private var imageSize: CGSize {
        let size: CGFloat = view.frame.width * sizeImageFactor
        return CGSize(width: size , height: size)
    }
    
    private var retryAction: (()) {
        self.presenter?.retry()
    }
    
    private var confirmationAction: (()) {
        self.presenter?.backToHome()
    }
    
    
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Home.CellDetail.title
        label.font = titleFont
        label.textColor = titleTextColor
        label.textAlignment = .left
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var titleDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = contentFont
        label.textColor = UIColor.gray
        label.numberOfLines = .zero
        label.textAlignment = .left
        return label
    }()
    
    private lazy var albumIdLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.Home.CellDetail.albumTitle
        label.font = titleFont
        label.textColor = titleTextColor
        label.numberOfLines = .zero
        label.textAlignment = .left
        return label
    }()
    
    private lazy var albumIdDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = contentFont
        label.textColor = contentTextColor
        label.numberOfLines = .zero
        label.textAlignment = .left
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        var config = UIButton.Configuration.borderless()
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20)
        let button = UIButton(configuration: config)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 16
        button.setTitle(Strings.Detail.deleteAction, for: .normal)
        button.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        return button
    }()

    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    // MARK: Private func
    
    private func addImage(photo: Photo) {
        let imageView = photo.getImageView()
        self.imageView = imageView
        view.addSubview(imageView)
        imageView.autoSetDimensions(to: imageSize)
        imageView.autoAlignAxis(toSuperviewAxis: .horizontal)
        imageView.autoAlignAxis(toSuperviewAxis: .vertical)
    }
    
    private func addTitle(title: String) {
        guard let imageView = imageView else { return }
        view.addSubview(titleLabel)
        titleLabel.autoPinEdge(toSuperviewEdge: .left, withInset: titleMargin.left)
        titleLabel.autoPinEdge(toSuperviewEdge: .right, withInset: titleMargin.right)
        titleLabel.autoPinEdge(.top, to: .bottom, of: imageView, withOffset: titleMargin.top)
        view.addSubview(titleDescriptionLabel)
        titleDescriptionLabel.text = title
        titleDescriptionLabel.autoPinEdge(.top, to: .bottom, of: titleLabel, withOffset: titleMargin.bottom)
        titleDescriptionLabel.autoPinEdge(toSuperviewEdge: .right, withInset: titleMargin.right)
        titleDescriptionLabel.autoPinEdge(toSuperviewEdge: .left, withInset: titleMargin.left)
    }
    
    private func addAlbum(album: String) {
        view.addSubview(albumIdLabel)
        albumIdLabel.autoPinEdge(.top, to: .bottom, of: titleDescriptionLabel, withOffset: albumMargin.top)
        albumIdLabel.autoPinEdge(toSuperviewEdge: .left, withInset: albumMargin.left)
        albumIdLabel.autoPinEdge(toSuperviewEdge: .right, withInset: albumMargin.right)
        view.addSubview(albumIdDescriptionLabel)
        albumIdDescriptionLabel.text = album
        albumIdDescriptionLabel.autoPinEdge(.top, to: .bottom, of: albumIdLabel, withOffset: albumMargin.bottom)
        albumIdDescriptionLabel.autoPinEdge(toSuperviewEdge: .right, withInset: albumMargin.right)
        albumIdDescriptionLabel.autoPinEdge(toSuperviewEdge: .left, withInset: albumMargin.left)
    }
    
    private func addButton() {
        view.addSubview(deleteButton)
        deleteButton.autoPinEdge(toSuperviewMargin: .bottom, withInset: buttonMargin.bottom)
        deleteButton.autoAlignAxis(toSuperviewAxis: .vertical)
    }
    
    @objc private func deleteAction() {
        presenter?.deleteImage()
    }


}

// MARK: DetailViewProtocol
extension DetailViewController: DetailViewProtocol {
    func showConfirmation() {
        let alertController = UIAlertController(title: Strings.Detail.PopUpMessage.Success.message, message: nil, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: Strings.Detail.PopUpMessage.Success.action, style: .default) { [weak self] _ in
            self?.confirmationAction
        }
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
    
    func showErrorMessage() {
        let alertController = UIAlertController(title: Strings.Detail.PopUpMessage.Failure.message, message: nil, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: Strings.Detail.PopUpMessage.Failure.retry, style: .default) {[weak self]  _ in
            self?.retryAction
        }
        let laterAction = UIAlertAction(title: Strings.Detail.PopUpMessage.Failure.later, style: .default)
        alertController.addAction(retryAction)
        alertController.addAction(laterAction)
        present(alertController, animated: true)
    }
    
    func showPendingDeletionMessage() {
        let alertController = UIAlertController(title: Strings.Detail.PopUpMessage.ConnetionFail.message, message: nil, preferredStyle: .alert)
        let laterAction = UIAlertAction(title: Strings.Detail.PopUpMessage.ConnetionFail.later, style: .default){ [weak self] _ in
            self?.confirmationAction
        }
        alertController.addAction(laterAction)
        present(alertController, animated: true)
    }
    
    func setupView(photo: Photo) {
        addImage(photo: photo)
        addTitle(title: photo.title)
        addAlbum(album: photo.getAlbumString())
        addButton()
    }
}
