//
//  EmployeeTableViewCell.swift
//  AvitoInternTest
//
//  Created by Dilshodi Kahori on 27/10/22.
//

import UIKit
import SnapKit

class EmployeeTableViewCell: UITableViewCell {
    
    //MARK: - Data layer
    var content: Organization.Employee? {
        didSet {
            guard let content = content else {
                return
            }
            employeeName.text = content.name
            employeePhone.text = content.phoneNumber
            var text = ""
            for skill in content.skills {
                text += skill + ","
                print(text)
            }
            skillsLabel.text = "Skills: " + text
        }
    }

    // MARK: - UI
    private lazy var employeeName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        addSubview(label)
        return label
    }()
    
    private lazy var employeePhone: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .lightGray
        addSubview(label)
        return label
    }()
    
    private lazy var skillsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .lightGray
        addSubview(label)
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constraints
   private func makeConstraints() {
       employeeName.snp.makeConstraints { make in
           make.top.equalToSuperview().inset(8)
           make.leading.equalToSuperview().inset(16)
       }
       
       employeePhone.snp.makeConstraints { make in
           make.top.equalTo(employeeName.snp.bottom).offset(4)
           make.leading.equalToSuperview().inset(16)
       }
       
       skillsLabel.snp.makeConstraints { make in
           make.top.equalTo(employeePhone.snp.bottom).offset(4)
           make.leading.equalToSuperview().inset(16)
           make.bottom.equalToSuperview().inset(8)
       }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        employeeName.text = nil
        employeePhone.text = nil
        skillsLabel.text = nil
    }
}
