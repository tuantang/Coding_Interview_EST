//
//  ListViewModel.swift
//  Boilerplate-iOS
//
//  Created by Tuan Tang on 14/03/2022.
//

import RxSwift
import RxCocoa

protocol ListViewModelInputs {
    func refresh()
    var loadTrigger: PublishSubject<Void> { get }
}

protocol ListViewModelOutputs {
    var repo: BehaviorRelay<(data: [User]?, error: GenericError?)> { get }
    var indicator: Driver<Bool> { get }
    var error: PublishSubject<Error> { get }
}

protocol ListViewModelType {
    var inputs: ListViewModelInputs { get }
    var outputs: ListViewModelOutputs { get }
}

class ListViewModel: ListViewModelType, ListViewModelInputs, ListViewModelOutputs {

    internal var loadTrigger: PublishSubject<Void>
    
    internal var repo: BehaviorRelay<(data: [User]?, error: GenericError?)>
    internal var indicator: Driver<Bool>
    internal var error: PublishSubject<Error>
    
    var inputs: ListViewModelInputs { return self }
    var outputs: ListViewModelOutputs { return self }
    
    private let disposeBag = DisposeBag()
    private let githubRequest = GithubRequest()
    
    init() {
        
        self.loadTrigger = PublishSubject<Void>()
        
        let ActivityIndicator = ActivityIndicator()
        self.indicator = ActivityIndicator.asDriver()
        
        self.repo = BehaviorRelay<(data: [User]?, error: GenericError?)>(value: (data: nil, error: nil))
        self.error = PublishSubject<Error>()
        
        
        let loadRequest = self.indicator.asObservable()
            .sample(self.loadTrigger)
            .flatMap { [weak self] isLoading -> Observable<(data: [User]?, error: GenericError?)> in
                guard let self = self else { return  Observable.empty() }
                return isLoading ? Observable.empty() : self.githubRequest.getUsers().trackActivity(ActivityIndicator)
            }
        loadRequest
            .bind(to: self.repo)
            .disposed(by: disposeBag)
        
    }
    
    public func refresh() {
        self.loadTrigger
            .onNext(())
    }

}
