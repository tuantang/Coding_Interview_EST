//
//  DetailViewModel.swift
//  Boilerplate-iOS
//
//  Created by Tuan Tang on 15/03/2022.
//

import RxSwift
import RxCocoa

protocol DetailViewModelInputs {
    func loadDetail()
    func saveToRealm(user: User)
    var loadTrigger: PublishSubject<Void> { get }
}

protocol DetailViewModelOutputs {
    var element: BehaviorRelay<(data: User?, error: GenericError?)> { get }
    var indicator: Driver<Bool> { get }
}

protocol DetailViewModelType {
    var inputs: DetailViewModelInputs { get }
    var outputs: DetailViewModelOutputs { get }
}

class DetailViewModel: DetailViewModelType, DetailViewModelInputs, DetailViewModelOutputs {
    
    
    var loadTrigger: PublishSubject<Void>
    
    var element: BehaviorRelay<(data: User?, error: GenericError?)>
    var indicator: Driver<Bool>
    
    var inputs: DetailViewModelInputs { return self }
    var outputs: DetailViewModelOutputs { return self }
        
    private let disposeBag = DisposeBag()
    private let githubRequest = GithubRequest()
    private let userRealmService = RealmService.User
    
    init(user: User) {
        
        self.loadTrigger = PublishSubject<Void>()
        
        let ActivityIndicator = ActivityIndicator()
        self.indicator = ActivityIndicator.asDriver()
        
        self.element = BehaviorRelay<(data: User?, error: GenericError?)>(value: (data: userRealmService.findUser(by: user.id ?? 0), error: nil))
        
        let loadRequest = self.indicator.asObservable()
            .sample(self.loadTrigger)
            .flatMap { [weak self] isLoading -> Observable<(data: User?, error: GenericError?)> in
                guard let self = self,
                      let login = user.login else { return  Observable.empty() }
                return isLoading ? Observable.empty() : self.githubRequest.getDetail(login: login).trackActivity(ActivityIndicator)
            }
        loadRequest
            .bind(to: element)
            .disposed(by: disposeBag)
    }
    
    func loadDetail() {
        self.loadTrigger
            .onNext(())
    }
    
    func saveToRealm(user: User) {
        self.userRealmService.saveUser(element: user)
    }
}
