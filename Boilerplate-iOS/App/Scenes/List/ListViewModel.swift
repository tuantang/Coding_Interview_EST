//
//  ListViewModel.swift
//  Boilerplate-iOS
//
//  Created by Tuan Tang on 14/03/2022.
//

import RxSwift
import RxCocoa
import RealmSwift

protocol ListViewModelInputs {
    func refresh()
    func tapped(indexRow: Int)
    func saveToRealm(users: [User])
    var loadTrigger: PublishSubject<Void> { get }
}

protocol ListViewModelOutputs {
    var repo: BehaviorRelay<(data: [User]?, error: GenericError?)> { get }
    var indicator: Driver<Bool> { get }
    var selectedViewModel: Driver<DetailViewModel> { get }
}

protocol ListViewModelType {
    var inputs: ListViewModelInputs { get }
    var outputs: ListViewModelOutputs { get }
}

class ListViewModel: ListViewModelType, ListViewModelInputs, ListViewModelOutputs {

    internal var loadTrigger: PublishSubject<Void>
    
    internal var repo: BehaviorRelay<(data: [User]?, error: GenericError?)>
    internal var indicator: Driver<Bool>
    public var selectedViewModel: Driver<DetailViewModel>
    
    var inputs: ListViewModelInputs { return self }
    var outputs: ListViewModelOutputs { return self }
    
    let selectedUser = BehaviorRelay<User?>(value: nil)
    
    private let disposeBag = DisposeBag()
    private let githubRequest = GithubRequest()
    private let userRealmService = RealmService.User
    
    init() {
        
        self.loadTrigger = PublishSubject<Void>()
        
        let ActivityIndicator = ActivityIndicator()
        self.indicator = ActivityIndicator.asDriver()
        self.selectedViewModel = Driver.empty()
        
        self.repo = BehaviorRelay<(data: [User]?, error: GenericError?)>(value: (data: userRealmService.allUser(), error: nil))
        
        let loadRequest = self.indicator.asObservable()
            .sample(self.loadTrigger)
            .flatMap { [weak self] isLoading -> Observable<(data: [User]?, error: GenericError?)> in
                guard let self = self else { return  Observable.empty() }
                return isLoading ? Observable.empty() : self.githubRequest.getUsers().trackActivity(ActivityIndicator)
            }
        loadRequest
            .bind(to: self.repo)
            .disposed(by: disposeBag)
        
        self.selectedViewModel = self.selectedUser.asDriver()
            .flatMapLatest { user -> Driver<DetailViewModel> in
                guard let user = user else { return Driver.empty() }
                return Driver.just(DetailViewModel(user: user))
            }
    }
    
    func refresh() {
        self.loadTrigger
            .onNext(())
    }
    
    func tapped(indexRow: Int) {
        guard let users = self.repo.value.data, users.count > indexRow else { return }
        let user = users[indexRow]
        self.selectedUser.accept(user)
    }
    
    func saveToRealm(users: [User]) {
        users.forEach { self.userRealmService.saveUser(element: $0) }
    }

}
