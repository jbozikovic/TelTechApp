//
//  EmployeeDetailsCell.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 02.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import UIKit

// MARK: - EmployeeDetailsCellConstants
private struct EmployeeDetailsCellConstants {
    private init() {}
    
    static let valueNumberOfLines: Int = 0
    static let offset: CGFloat = 10.0
    static let leadingTrailingOffset: CGFloat = 20.0
    static let labelHeight: CGFloat = 21.0
}


// MARK: - EmployeeDetailsCell
class EmployeeDetailsCell: UITableViewCell, Configurable {
    typealias T = EmployeeDetailsCellViewModel
    lazy var captionLabel = UILabel(frame: .zero)
    lazy var valueLabel = UILabel(frame: .zero)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupGUI()
    }
    
    func configure(_ item: EmployeeDetailsCellViewModel) {
        setupGUI()
        captionLabel.text = item.caption.uppercased()
        valueLabel.text = item.value
    }
}


// MARK: - Setup GUI
private extension EmployeeDetailsCell {
    func setupGUI() {
        backgroundColor = .clear
        selectionStyle = .none
        addSubviews()
        Utility.setupLabel(captionLabel, font: AppUI.defaultFontBold, textColor: AppUI.titleFontColor)
        Utility.setupLabel(valueLabel, font: AppUI.defaultFont, textColor: AppUI.bodyFontColor, numberOfLines: EmployeeDetailsCellConstants.valueNumberOfLines)
        setupConstraints()
    }
    
    func addSubviews() {
        [captionLabel, valueLabel].forEach { subView in
            addSubview(subView)
        }
    }
}


// MARK: - Setup constraints
private extension EmployeeDetailsCell {
    func setupConstraints() {
        setupCaptionConstraints()
        setupValueConstraints()
    }
    
    func setupCaptionConstraints() {
        captionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(EmployeeDetailsCellConstants.offset)
            make.leading.equalToSuperview().offset(EmployeeDetailsCellConstants.leadingTrailingOffset)
            make.trailing.equalToSuperview().offset(-EmployeeDetailsCellConstants.leadingTrailingOffset)
            make.height.equalTo(EmployeeDetailsCellConstants.labelHeight)
        }
    }

    func setupValueConstraints() {
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(captionLabel.snp.bottom).offset(EmployeeDetailsCellConstants.offset)
            make.leading.equalTo(captionLabel.snp.leading)
            make.trailing.equalToSuperview().offset(-EmployeeDetailsCellConstants.leadingTrailingOffset)
            make.bottom.equalToSuperview().offset(-EmployeeDetailsCellConstants.offset)
            make.height.greaterThanOrEqualTo(EmployeeDetailsCellConstants.labelHeight)            
        }
    }
}


// MARK: - Reusable
extension EmployeeDetailsCell: Reusable {
    static var estimatedHeight: CGFloat {
        return 100.0
    }
}
