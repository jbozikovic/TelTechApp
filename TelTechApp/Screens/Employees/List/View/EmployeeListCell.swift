//
//  EmployeeListCell.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 02.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import UIKit

// MARK: - EmployeeListCellConstants
private struct EmployeeListCellConstants {
    private init() {}
    
    static let introNumberOfLines: Int = 2
    static let offset: CGFloat = 10.0
    static let avatarSize: CGFloat = 60
    static let leadingTrailingOffset: CGFloat = 20.0
    static let labelHeight: CGFloat = 21.0
}


// MARK: - EmployeeListCell
class EmployeeListCell: UITableViewCell, Configurable {
    typealias T = EmployeeCellViewModel
    lazy var employeeImageView = RoundedImageView(frame: .zero)
    lazy var nameLabel = UILabel(frame: .zero)
    lazy var titleLabel = UILabel(frame: .zero)
    lazy var introLabel = UILabel(frame: .zero)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupGUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(_ item: EmployeeCellViewModel) {
        setupGUI()
        employeeImageView.image = item.employeeImage
        nameLabel.text = item.name
        titleLabel.text = item.title
        introLabel.text = item.intro        
    }
}


// MARK: - Setup GUI
private extension EmployeeListCell {
    func setupGUI() {
        backgroundColor = .clear        
        addSubviews()        
        Utility.setupLabel(nameLabel, font: AppUI.listTitleFont, textColor: AppUI.titleFontColor)
        Utility.setupLabel(titleLabel, font: AppUI.defaultFont, textColor: AppUI.bodyFontColor)
        Utility.setupLabel(introLabel, font: AppUI.defaultFont, textColor: AppUI.bodyFontColor, numberOfLines: EmployeeListCellConstants.introNumberOfLines)
        setupConstraints()
    }
    
    func addSubviews() {
        [employeeImageView, nameLabel, titleLabel, introLabel].forEach { subView in
            addSubview(subView)
        }
    }
}


// MARK: - Setup constraints
private extension EmployeeListCell {
    func setupConstraints() {
        setupImageViewConstraints()
        setupNameConstraints()
        setupTitleConstraints()
        setupIntroConstraints()
    }

    func setupImageViewConstraints() {
        employeeImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(EmployeeListCellConstants.offset)
            make.leading.equalToSuperview().offset(EmployeeListCellConstants.leadingTrailingOffset)
            make.width.equalTo(EmployeeListCellConstants.avatarSize)
            make.height.equalTo(EmployeeListCellConstants.avatarSize)
        }
    }

    func setupNameConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(EmployeeListCellConstants.offset)
            make.leading.equalTo(employeeImageView.snp.trailing).offset(EmployeeListCellConstants.offset)
            make.trailing.equalToSuperview().offset(-EmployeeListCellConstants.leadingTrailingOffset)
            make.height.equalTo(EmployeeListCellConstants.labelHeight)
        }
    }

    func setupTitleConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(EmployeeListCellConstants.offset)
            make.leading.equalTo(nameLabel.snp.leading)
            make.height.equalTo(EmployeeListCellConstants.labelHeight)
            make.trailing.equalToSuperview().offset(-EmployeeListCellConstants.leadingTrailingOffset)
        }
    }

    func setupIntroConstraints() {
        introLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(EmployeeListCellConstants.offset)
            make.leading.equalTo(nameLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-EmployeeListCellConstants.leadingTrailingOffset)
            make.height.greaterThanOrEqualTo(EmployeeListCellConstants.labelHeight)
            make.bottom.equalToSuperview().offset(-EmployeeListCellConstants.offset)
        }
    }
}


// MARK: - Reusable
extension EmployeeListCell: Reusable {
    static var estimatedHeight: CGFloat {
        return 100.0
    }
}
