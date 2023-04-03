//
//  EmployeeDetailsHeaderView.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 02.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import UIKit

// MARK: - EmployeeDetailsHeaderViewConstants
private struct EmployeeDetailsHeaderViewConstants {
    private init() {}

    static let nameNumberOfLines: Int = 2
    static let introNumberOfLines: Int = 0
    static let offset: CGFloat = 10.0
    static let avatarSize: CGFloat = 150.0
    static let leadingTrailingOffset: CGFloat = 20.0
    static let labelHeight: CGFloat = 30.0
}


// MARK: - EmployeeDetailsHeaderView
class EmployeeDetailsHeaderView: UITableViewHeaderFooterView, Configurable {
    typealias T = EmployeeDetailsHeaderViewModel    
    lazy var nameLabel = UILabel(frame: .zero)
    lazy var avatarImageView = RoundedImageView(frame: .zero)
    lazy var introLabel = UILabel(frame: .zero)
    
    private var viewModel: EmployeeDetailsHeaderViewModel? = nil {
        didSet {
            fillData()
        }
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupGUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
                
    func configure(_ item: EmployeeDetailsHeaderViewModel) {
        self.viewModel = item
    }
    
    private func fillData() {
        guard let vm = viewModel else { return }
        avatarImageView.image = vm.employeeImage
        nameLabel.text = vm.name
        introLabel.text = vm.intro
    }
}


// MARK: - Setup GUI
private extension EmployeeDetailsHeaderView {
    func setupGUI() {
        addSubviews()
        avatarImageView.tintColor = .gray
        Utility.setupLabel(nameLabel, font: AppUI.titleFont, textColor: AppUI.titleFontColor, numberOfLines: EmployeeDetailsHeaderViewConstants.nameNumberOfLines, textAlignment: NSTextAlignment.center)
        Utility.setupLabel(introLabel, font: AppUI.defaultFont, textColor: AppUI.bodyFontColor, numberOfLines: EmployeeDetailsHeaderViewConstants.introNumberOfLines, textAlignment: NSTextAlignment.center)
        setupConstraints()
    }
    
    func addSubviews() {
        [avatarImageView, nameLabel, introLabel].forEach { subView in
            addSubview(subView)
        }
    }
}


// MARK: - Setup constraints
private extension EmployeeDetailsHeaderView {
    func setupConstraints() {
        setupNameConstraints()
        setupAvatarConstraints()
        setupIntroConstraints()
    }
    
    func setupNameConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(EmployeeDetailsHeaderViewConstants.offset)
            make.leading.equalToSuperview().offset(EmployeeDetailsHeaderViewConstants.leadingTrailingOffset)
            make.trailing.equalToSuperview().offset(-EmployeeDetailsHeaderViewConstants.leadingTrailingOffset)
            make.height.greaterThanOrEqualTo(EmployeeDetailsHeaderViewConstants.labelHeight)
        }
    }
    
    func setupAvatarConstraints() {
        avatarImageView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(EmployeeDetailsHeaderViewConstants.offset)
            make.centerX.equalToSuperview()
            make.width.equalTo(EmployeeDetailsHeaderViewConstants.avatarSize)
            make.height.equalTo(EmployeeDetailsHeaderViewConstants.avatarSize)
        }
    }
    
    func setupIntroConstraints() {
        introLabel.snp.makeConstraints { make in
            make.top.equalTo(avatarImageView.snp.bottom).offset(EmployeeDetailsHeaderViewConstants.offset)
            make.leading.equalToSuperview().offset(EmployeeDetailsHeaderViewConstants.leadingTrailingOffset)
            make.trailing.equalToSuperview().offset(-EmployeeDetailsHeaderViewConstants.leadingTrailingOffset)
            make.bottom.equalToSuperview().offset(-EmployeeDetailsHeaderViewConstants.offset)
            make.height.greaterThanOrEqualTo(EmployeeDetailsHeaderViewConstants.labelHeight)
        }
    }
}


// MARK: - Reusable
extension EmployeeDetailsHeaderView: Reusable {
    static var estimatedHeight: CGFloat {
        return 250.0
    }
}
