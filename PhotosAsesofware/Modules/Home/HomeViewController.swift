//
//  HomeViewController.swift
//  Created by David Felipe Cortes Gonzalez on 10/04/24.

import UIKit

final class HomeViewController: BaseViewController {
    
    // MARK: var - let
    var presenter: HomePresenterProtocol?
    
    private var retryAction: (()) {
        self.presenter?.viewDidLoad()
    }
    
    // MARK: Private var -let
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 112
        return tableView
    }()

    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewDidLoad()
    }
    
    // MARK: Private func
    private func addTableView() {
        view.addSubview(tableView)
        let leadingConstraint = tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingConstraint = tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let topConstraint = tableView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottomConstraint = tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }

}

// MARK: HomeViewProtocol
extension HomeViewController: HomeViewProtocol {
    func reloadPhotos() {
        tableView.reloadData()
    }
    
    func showError() {
        let alertController = UIAlertController(title: Strings.Home.PopUpMessage.title, message: nil, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: Strings.Home.PopUpMessage.action, style: .default) {[weak self]  _ in
            self?.retryAction
        }
        let laterAction = UIAlertAction(title: Strings.Detail.PopUpMessage.Failure.later, style: .default)
        alertController.addAction(retryAction)
        alertController.addAction(laterAction)
        present(alertController, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath)
        guard let cell = cell as? PhotoTableViewCell, let model = presenter?.photo(at: indexPath.row) else {
            return cell
        }
        cell.setupCellWith(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.numberOfPhotos() ?? .zero
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showPhotoDetail(at: indexPath.row)
    }
}
