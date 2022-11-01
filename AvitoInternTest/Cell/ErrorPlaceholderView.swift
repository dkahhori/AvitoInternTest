//
//  ErrorPlaceholderView.swift
//  AvitoInternTest
//
//  Created by Dilshodi Kahori on 28/10/22.
//

import UIKit

class ErrorPlaceholderView: UIView {
    
    // MARK: - Property
    var onClick: (() -> Void)?
    
    // MARK: - UI
    lazy var errorTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    lazy var errorMessage: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    lazy var getDataButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.setTitle("Try again", for: .normal)
        button.addTarget(self, action: #selector(fetchData), for: .touchUpInside)
        button.backgroundColor = .black
        return button
    }()
    
    @objc
    private func fetchData() {
        onClick?()
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(errorTitle)
        addSubview(errorMessage)
        addSubview(getDataButton)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeConstraints() {
        errorTitle.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        errorMessage.snp.makeConstraints { make in
            make.top.equalTo(errorTitle.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        getDataButton.snp.makeConstraints { make in
            make.top.equalTo(errorMessage.snp.bottom).offset(14)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(120)
        }
    }
}
