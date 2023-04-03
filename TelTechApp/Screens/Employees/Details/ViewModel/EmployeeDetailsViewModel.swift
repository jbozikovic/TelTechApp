//
//  EmployeeDetailsViewModel.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 02.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import Foundation
import Combine

//  MARK: - EmployeeDetailsViewModelSection
enum EmployeeDetailsViewModelSection: Int, CaseIterable {
    case title
    case team
    case description
    case agency
                
    var title: String {
        switch self {
        case .title:
            return AppStrings.title.localized
        case .team:
            return AppStrings.team.localized
        case .description:
            return AppStrings.aboutMe.localized
        case .agency:
            return AppStrings.agency.localized
        }
    }
}


//  MARK: - EmployeeDetailsViewModel
class EmployeeDetailsViewModel {
    private(set) var haederViewModel: EmployeeDetailsHeaderViewModel?
    private(set) var cellViewModels: [EmployeeDetailsCellViewModel] = []
    private var cancellables = Set<AnyCancellable>()
    private(set) var employee: Employee {
        didSet {
            prepareDataAndReload()
        }
    }
        
    // MARK: - Publishers    
    lazy var shouldReloadData = PassthroughSubject<Void, Never>()
    
    init(employee: Employee) {
        self.employee = employee
        prepareDataAndReload()
    }
    
    //  MARK: - Load data
    private func prepareDataAndReload() {
        haederViewModel = EmployeeDetailsHeaderViewModel(employee: employee)
        cellViewModels = [
            EmployeeDetailsCellViewModel(caption: EmployeeDetailsViewModelSection.title.title, value: employee.title),
            EmployeeDetailsCellViewModel(caption: EmployeeDetailsViewModelSection.team.title, value: employee.team.capitalized),
            EmployeeDetailsCellViewModel(caption: EmployeeDetailsViewModelSection.description.title, value: employee.description),
            EmployeeDetailsCellViewModel(caption: EmployeeDetailsViewModelSection.agency.title, value: agency)
        ]
        shouldReloadData.send()
    }
}


//  MARK: - Number of items,views visibility...
extension EmployeeDetailsViewModel {
    var title: String {
        return AppStrings.details.localized
    }
    var numberOfItems: Int {
        return cellViewModels.count
    }
    var numberOfSections: Int {
        return Constants.defaultNumberOfSections
    }
    var agency: String {
        return employee.agency.isEmpty ? AppStrings.notAvailable.localized : employee.agency
    }
        
    func getItemAtIndex(_ index: Int) -> EmployeeDetailsCellViewModel? {
        guard !cellViewModels.isEmpty, index < cellViewModels.count else { return nil }
        return cellViewModels[index]
    }
}
