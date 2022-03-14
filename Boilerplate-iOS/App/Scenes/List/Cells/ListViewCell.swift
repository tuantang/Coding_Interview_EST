//
//  ListViewCell.swift
//  Boilerplate-iOS
//
//  Created by Tuan Tang on 14/03/2022.
//

import UIKit
import Kingfisher

class ListViewCell: UITableViewCell {
    
    private var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private var loginLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .darkGray
        return label
    }()
    
    private var htmlLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.configureCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.avatarImageView.image = nil
    }
    
    func configureCell() {
        self.selectionStyle = .none
        
        adjustUI()
    }
    
    func configureModel(model: User) {
        guard let avatarURL = URL(string: model.avatarURL)  else { return }
        self.avatarImageView.kf.setImage(with: avatarURL)
        self.loginLabel.text = model.login
        self.htmlLabel.text = model.htmlURL
    }
}

extension ListViewCell {
    func adjustUI() {
        let labelStackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [self.loginLabel, self.htmlLabel])
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
        
        
        
        self.contentView.addSubview(coverStackView)
        self.contentView.addSubview(lineView)
        
        coverStackView
            .top(self.contentView.topAnchor, constant: 15)
            .bottom(self.contentView.bottomAnchor, constant: 15)
            .leading(self.contentView.leadingAnchor, constant: 15)
        
        lineView
            .height(0.5)
            .leading(self.contentView.leadingAnchor)
            .trailing(self.contentView.trailingAnchor)
            .bottom(self.contentView.bottomAnchor)
        
        self.avatarImageView
            .width(50)
            .height(50)

    }
}

