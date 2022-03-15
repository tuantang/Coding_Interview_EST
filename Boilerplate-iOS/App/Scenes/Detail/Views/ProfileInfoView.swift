//
//  ProfileInfoView.swift
//  Boilerplate-iOS
//
//  Created by Tang Tuan on 3/15/22.
//

import UIKit

class ProfileInfoView: UIView {
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .darkGray
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
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
    
    func configureModel(avatarURL: String?, name: String?, localtion: String?) {
        if let avatarURL = avatarURL, let url = URL(string: avatarURL) {
            self.avatarImageView.kf.setImage(with: url)
        }
        self.nameLabel.text = name
        self.locationLabel.text = localtion
    }
}

extension ProfileInfoView {
    func adjustUI() {
        let labelStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [self.nameLabel, self.locationLabel])
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 8
            return stackView
        }()
        let coverStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [self.avatarImageView, labelStackView])
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 16
            return stackView
        }()
        let lineView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
            return view
        }()
        
        self.addSubview(coverStackView)
        self.addSubview(lineView)
        
        coverStackView
            .top(self.topAnchor, constant: 15)
            .bottom(self.bottomAnchor, constant: 15)
            .leading(self.leadingAnchor, constant: 15)
        
        lineView
            .height(0.5)
            .leading(self.leadingAnchor)
            .trailing(self.trailingAnchor)
            .bottom(self.bottomAnchor)
        
        self.avatarImageView
            .width(50)
            .height(50)

    }
}
