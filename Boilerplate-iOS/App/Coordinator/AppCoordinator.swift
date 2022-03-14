//
//  AppCoordinator.swift
//  Boilerplate-iOS
//
//  Created by Tuan Tang on 14/03/2022.
//

import UIKit
import RxSwift

class AppCoordinator: BaseCoordinator<Void> {
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() -> Observable<Void> {
        let listViewCoordinator = ListViewCoordinator(window: window)
        return coordinate(to: listViewCoordinator)
    }
}
