//
//  DetailViewController.swift
//  Boilerplate-iOS
//
//  Created by Tuan Tang on 15/03/2022.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet private weak var stackView: UIStackView!
    
    let profileInfoView = ProfileInfoView()
    let bioInfoView = BioInfoView()
    let followInfoView = FollowInfoView()
    
    private let disposeBag = DisposeBag()
    
    var viewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
}

fileprivate extension DetailViewController {
    func setup() {
        self.navigationItem.title = "Detail"
        self.view.backgroundColor = .white
        self.configureView()
        self.bindRx()
    }
    
    func configureView() {
        [self.profileInfoView, self.bioInfoView, self.followInfoView].forEach { self.stackView.addArrangedSubview($0) }
    }
    
    func bindRx() {
        self.viewModel.inputs.loadDetail()
        
        self.viewModel
            .outputs
            .element
            .asObservable()
            .subscribe(onNext: { [weak self] element in
                guard let self = self, let user = element.data else { return }
                self.profileInfoView.configureModel(avatarURL: user.avatarURL, name: user.name, localtion: user.location)
                self.bioInfoView.configureModel(bio: user.bio)
                self.followInfoView.configureModel(publicRepos: user.publicRepos, followers: user.followers, followings: user.following)
                self.viewModel.inputs.saveToRealm(user: user)
            }).disposed(by: disposeBag)
    }
}
