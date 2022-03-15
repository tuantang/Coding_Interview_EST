//
//  BioInfoView.swift
//  Boilerplate-iOS
//
//  Created by Tang Tuan on 3/15/22.
//

import UIKit

class BioInfoView: UIView {
    
    private let bioLabel: UILabel = {
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

    func configureModel(bio: String?) {
        self.bioLabel.text = bio
    }
}

extension BioInfoView {
    func adjustUI() {
        let aboutLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 18)
            label.textColor = .darkGray
            label.text = "About"
            return label
        }()
        
        let stackView: UIStackView = {
            let stackView = UIStackView(arrangedSubviews: [aboutLabel, self.bioLabel])
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 4
            return stackView
        }()
        
        let lineView: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
            return view
        }()
        
        self.addSubview(stackView)
        self.addSubview(lineView)
        
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
}
