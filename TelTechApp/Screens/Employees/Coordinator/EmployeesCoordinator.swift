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
    private let analyticsService: AnalyticsProtocol
        
    init(presenter: UINavigationController, analyticsService: AnalyticsProtocol) {
        self.presenter = presenter
        self.analyticsService = analyticsService
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
            weakSelf.logEvent(event: .userTappedEmployee)
        }.store(in: &cancellables)
    }
}


//  MARK: - Employees list
private extension EmployeesCoordinator {
    private func navigateToEmployeeListViewController() {
        guard let vm = viewModel else { return }
        let vc = EmployeeListViewController(viewModel: vm)
        presenter.pushViewController(vc, animated: true)
        trackScreen(viewController: vc)
    }
}


//  MARK: - Repository details
private extension EmployeesCoordinator {
    func navigateToEmployeeDetails(employee: Employee) {
        let viewModel = EmployeeDetailsViewModel(employee: employee)
        let vc = EmployeeDetailsViewController(viewModel: viewModel)
        presenter.pushViewController(vc, animated: true)
        trackScreen(viewController: vc)
    }
}


//  MARK: - Analytics
private extension EmployeesCoordinator {
    func trackScreen(viewController: UIViewController) {
        analyticsService.trackScreen(screenName: viewController.screenName)
    }
    
    func logEvent(event: AnalyticsEvents) {
        analyticsService.logEvent(event, parameters: nil)
    }
}
