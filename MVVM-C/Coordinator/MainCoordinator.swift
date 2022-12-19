//
//  MainCoordinator.swift
//  MVVM-C
//
//  Created by Samed Dağlı on 19.12.2022.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}

final class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func popToRoot() {
        navigationController.popToRootViewController(animated: true)
    }
    
    func start(){
        let vc = QuoteListVC()
        let viewModel = QuoteListVM(service: AppContainer.shared.service, coordinator: self)
        
        vc.viewModel = viewModel
        viewModel.delegate = vc
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToDetail(quote: Quote) {
        let vc = QuoteDetailVC()
        
        let viewModel = QuoteDetailVM(quote: quote, coordinator: self)
        vc.viewModel = viewModel

        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToAuthorDetail(authorName: String) {
        let vc = AuthorDetailVC()
        
        let viewModel = AuthorDetailVM(authorName: authorName, service: AppContainer.shared.service, coordinator: self)
        vc.viewModel = viewModel
        
        navigationController.pushViewController(vc, animated: true)
    }
    
}
