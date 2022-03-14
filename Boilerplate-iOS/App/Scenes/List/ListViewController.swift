//
//  ListViewController.swift
//  Boilerplate-iOS
//
//  Created by Tuan Tang on 14/03/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController, UITableViewDelegate {
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = .clear
        refreshControl.tintColor = .lightGray
        return refreshControl
    }()
    
    private let disposeBag = DisposeBag()
    
    var viewModel: ListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

}

fileprivate extension ListViewController {
    func setup() {
        self.navigationItem.title = "List"
        self.view.backgroundColor = .white
        
        self.configureTableView()
        self.bindRx()
    }
    
    func configureTableView() {
        self.view.addSubview(self.tableView)
        self.tableView.addSubview(self.refreshControl)
        
        self.tableView.register(ListViewCell.self, forCellReuseIdentifier: "cell")
        
        self.tableView
            .top(self.view.topAnchor)
            .bottom(self.view.bottomAnchor)
            .leading(self.view.leadingAnchor)
            .trailing(self.view.trailingAnchor)
        
        self.tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    func bindRx() {
        self.viewModel.inputs.refresh()
        
        self.viewModel
            .outputs
            .repo
            .map({ result -> [User] in
                return result.data ?? []
            })
            .bind(to: tableView.rx.items) { (tableView, index, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ListViewCell
                cell.configureModel(model: element)
                return cell
            }.disposed(by: disposeBag)
        
        self.refreshControl.rx.controlEvent(.valueChanged)
            .bind(to: self.viewModel.inputs.loadTrigger)
            .disposed(by: disposeBag)
        
        self.viewModel.outputs.indicator
            .asObservable()
            .subscribe(onNext: { [weak self] isLoading in
                guard let self = self else { return }
                if isLoading { self.refreshControl.endRefreshing() }
            })
            .disposed(by: disposeBag)

    }
    
}
