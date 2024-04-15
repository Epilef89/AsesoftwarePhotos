//
//  BaseViewController.swift
//  PhotosAsesofware
//
//  Created by David Felipe Cortes Gonzalez on 10/04/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    private var loaderView: LoaderView = LoaderView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func showLoader() {
        view.addSubview(loaderView)
        loaderView.autoPinEdgesToSuperviewEdges()
        view.bringSubviewToFront(loaderView)
    }
    
    func hideLoader() {
        DispatchQueue.main.async { [weak self] in
            self?.loaderView.removeFromSuperview()
        }
    }
}
