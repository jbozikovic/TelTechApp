//
//  EmployeeListViewModel.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 01.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import Foundation
import Combine

class EmployeeListViewModel: Loadable {
    private var employees: [Employee] = [] {
        didSet {
            prepareViewModels()
        }
    }
    private var cellViewModels: [EmployeeCellViewModel] = []
    private var repository: EmployeesRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
        
    //  MARK: - Loadable
    var isLoading: Bool = false
    var loadingStatusUpdated: PassthroughSubject<Bool, Never> = PassthroughSubject<Bool, Never>()
            
    // MARK: - Publishers
    lazy var didTapEmployee = PassthroughSubject<Employee, Never>()
    lazy var failure = PassthroughSubject<Error, Never>()
    lazy var shouldReloadData = PassthroughSubject<Void, Never>()
                    
    init(repository: EmployeesRepositoryProtocol) {
        self.repository = repository
    }
            
    //  MARK: - Load data
    func loadData() {
        updateLoadingStatus()
        repository.getEmployees().sink { [weak self] completion in
            guard let weakSelf = self else { return }
            weakSelf.updateLoadingStatus()
            switch completion {
            case .failure(let error):
                weakSelf.failure.send(error)
            case .finished:
                break            
            }
        } receiveValue: { [weak self] employees in
            guard let weakSelf = self else { return }
            weakSelf.prepareDataAndReload(employees: employees)
        }.store(in: &cancellables)        
    }
    
    //  MARK: - Prepare view models
    private func prepareDataAndReload(employees: [Employee]) {
        self.employees = employees
        shouldReloadData.send()
    }
    
    private func prepareViewModels() {
        cellViewModels = []
        cellViewModels = employees.map { EmployeeCellViewModel(employee: $0) }
    }
}


//  MARK: - Number of items,views visibility...
extension EmployeeListViewModel {
    var title: String {
        return AppStrings.employees.localized
    }
    var numberOfItems: Int {
        return cellViewModels.count
    }
    var numberOfSections: Int {
        return Constants.defaultNumberOfSections
    }
        
    func getItemAtIndex(_ index: Int) -> EmployeeCellViewModel? {
        guard !cellViewModels.isEmpty, index < cellViewModels.count else { return nil }
        return cellViewModels[index]
    }
    
    func userSelectedRow(index: Int) {
        guard let vm = getItemAtIndex(index) else { return }
        didTapEmployee.send(vm.employee)
    }
}



