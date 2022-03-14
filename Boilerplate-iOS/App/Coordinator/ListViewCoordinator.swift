//
//  ListViewCoordinator.swift
//  Boilerplate-iOS
//
//  Created by Tuan Tang on 14/03/2022.
//

import UIKit
import RxSwift

class ListViewCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let viewModel = ListViewModel()
        let viewController = ListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationController.navigationBar.tintColor = .black
        
        viewController.viewModel = viewModel
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return Observable.never()
    }
}
