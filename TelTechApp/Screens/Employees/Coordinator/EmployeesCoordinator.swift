//
//  EmployeesCoordinator.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 02.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import UIKit
import Combine

class EmployeesCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var presenter: UINavigationController
    var viewModel: EmployeeListViewModel?
    var repository: EmployeesRepositoryProtocol
    private var cancellables = Set<AnyCancellable>()
        
    init(presenter: UINavigationController) {
        self.presenter = presenter
        childCoordinators = []
        let localStorageService = EmployeesLocalStorageService(fileManager: FilesManager(), fileName: AppConfig.dataFileName, fileExtension: Constants.jsonFileExtension)
        repository = EmployeesRepository(localStorageService: localStorageService)
    }
    
    func start() {
        setupViewModel()
        navigateToEmployeeListViewController()
    }
}


//  MARK: - View model
private extension EmployeesCoordinator {
    private func setupViewModel() {
        viewModel = EmployeeListViewModel(repository: repository)
        handleDidTapEmployeePublisher()
    }
    
    func handleDidTapEmployeePublisher() {
        viewModel?.didTapEmployee.sink { [weak self] (employee) in
            guard let weakSelf = self else { return }
            weakSelf.navigateToEmployeeDetails(employee: employee)
        }.store(in: &cancellables)
    }
}


//  MARK: - Employees list
private extension EmployeesCoordinator {
    private func navigateToEmployeeListViewController() {
        guard let vm = viewModel else { return }
        let vc = EmployeeListViewController(viewModel: vm)
        presenter.pushViewController(vc, animated: true)
    }
}


//  MARK: - Repository details
private extension EmployeesCoordinator {
    func navigateToEmployeeDetails(employee: Employee) {
        let viewModel = EmployeeDetailsViewModel(employee: employee)
        let vc = EmployeeDetailsViewController(viewModel: viewModel)
        presenter.pushViewController(vc, animated: true)
    }
}

