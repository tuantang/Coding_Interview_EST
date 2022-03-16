//
//  FollowInfoView.swift
//  Boilerplate-iOS
//
//  Created by Tang Tuan on 3/15/22.
//

import UIKit

class FollowInfoView: UIView {
    
    private let pulicReposLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .red
        return label
    }()
    
    private let followersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .red
        return label
    }()
    
    private let followingsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .red
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureView()
    }
    
    func configureView() {
        self.adjustUI()
    }

    func configureModel(publicRepos: Int?, followers: Int?, followings: Int?) {
        self.pulicReposLabel.text = "\(publicRepos ?? 0)"
        self.followersLabel.text = "\(followers ?? 0)"
        self.followingsLabel.text = "\(followings ?? 0)"
    }
}

extension FollowInfoView {
    func adjustUI() {
        let statsLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.textColor = .darkGray
            label.text = "Stats"
            return label
        }()
        
        let followView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            stackView.spacing = 16
            return stackView
        }()
        
        let stackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [statsLabel, followView])
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 8
            return stackView
        }()
        
        
        
        let lineView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
            return view
        }()
        
        
        self.addSubview(stackView)
        self.addSubview(lineView)
        
        [
            getStackView(title: "PUBLIC REPO", label: pulicReposLabel),
            getStackView(title: "FOLLOWERS", label: followersLabel),
            getStackView(title: "FOLLOWINGS", label: followingsLabel)
        ].forEach { followView.addArrangedSubview($0) }
        
        stackView
            .top(self.topAnchor, constant: 15)
            .bottom(self.bottomAnchor, constant: 15)
            .leading(self.leadingAnchor, constant: 15)
        
        lineView
            .height(0.5)
            .leading(self.leadingAnchor)
            .trailing(self.trailingAnchor)
            .bottom(self.bottomAnchor)
    }
    
    
    func getStackView(title: String, label: UILabel) -> UIStackView {
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = .lightGray
            label.text = title
            return label
        }()
        
        let stackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [label, titleLabel])
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 8
            return stackView
        }()
        
        return stackView
    }
    
}
