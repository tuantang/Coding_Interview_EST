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
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
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
        self.configureTableView()
    }
    
    func configureTableView() {
        self.view.addSubview(self.tableView)
        
        self.tableView.register(ListViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView
            .top(self.view.topAnchor)
            .bottom(self.view.bottomAnchor)
            .leading(self.view.leadingAnchor)
            .trailing(self.view.trailingAnchor)
        
        self.tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
}
