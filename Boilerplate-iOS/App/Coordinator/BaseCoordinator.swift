//
//  BaseCoordinator.swift
//  Boilerplate-iOS
//
//  Created by Tuan Tang on 14/03/2022.
//

import RxSwift

class BaseCoordinator<ResultType> {
    
    let disposeBag = DisposeBag()
    
    typealias CoordinationResult = ResultType
    private let identifier = UUID()
    private var childCoordinators = [UUID: Any]()
    
    private func store<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = coordinator
    }
    
    private func free<T>(coordinator: BaseCoordinator<T>) {
        childCoordinators[coordinator.identifier] = nil
    }
    
    func coordinate<T>(to coordinator: BaseCoordinator<T>) -> Observable<T> {
        store(coordinator: coordinator)
        return coordinator.start()
            .do(onNext: { [weak self] _ in self?.free(coordinator: coordinator) })
    }
    
    func start() -> Observable<ResultType> {
        fatalError("Start method should be implemented.")
    }
}
