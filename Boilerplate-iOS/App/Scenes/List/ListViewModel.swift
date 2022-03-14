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
    func tapped(indexRow: Int)
    var loadTrigger: PublishSubject<Void> { get }
}

protocol ListViewModelOutputs {
    var elements: BehaviorRelay<(data: [User]?, error: GenericError?)> { get }
    var indicator: Driver<Bool> { get }
    var selectedViewModel: Driver<DetailViewModel> { get }
}

protocol ListViewModelType {
    var inputs: ListViewModelInputs { get }
    var outputs: ListViewModelOutputs { get }
}

class ListViewModel: ListViewModelType, ListViewModelInputs, ListViewModelOutputs {

    internal var loadTrigger: PublishSubject<Void>
    
    internal var elements: BehaviorRelay<(data: [User]?, error: GenericError?)>
    internal var indicator: Driver<Bool>
    public var selectedViewModel: Driver<DetailViewModel>
    
    var inputs: ListViewModelInputs { return self }
    var outputs: ListViewModelOutputs { return self }
    
    let selectedUser = BehaviorRelay<User?>(value: nil)
    
    private let disposeBag = DisposeBag()
    private let githubRequest = GithubRequest()
    
    init() {
        
        self.loadTrigger = PublishSubject<Void>()
        
        let ActivityIndicator = ActivityIndicator()
        self.indicator = ActivityIndicator.asDriver()
        self.selectedViewModel = Driver.empty()
        
        self.elements = BehaviorRelay<(data: [User]?, error: GenericError?)>(value: (data: nil, error: nil))
        
        let loadRequest = self.indicator.asObservable()
            .sample(self.loadTrigger)
            .flatMap { [weak self] isLoading -> Observable<(data: [User]?, error: GenericError?)> in
                guard let self = self else { return  Observable.empty() }
                return isLoading ? Observable.empty() : self.githubRequest.getUsers().trackActivity(ActivityIndicator)
            }
        loadRequest
            .bind(to: self.elements)
            .disposed(by: disposeBag)
        
        self.selectedViewModel = self.selectedUser.asDriver()
            .compactMap { $0 }
            .flatMapLatest { user -> Driver<DetailViewModel> in
                return Driver.just(DetailViewModel(user: user))
            }
    }
    
    public func refresh() {
        self.loadTrigger
            .onNext(())
    }
    
    public func tapped(indexRow: Int) {
        guard let users = self.elements.value.data, users.count > indexRow else { return }
        let user = users[indexRow]
        self.selectedUser.accept(user)
    }

}
