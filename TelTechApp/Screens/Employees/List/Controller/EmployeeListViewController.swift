//
//  EmployeeListViewController.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 02.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import UIKit
import Combine
import SnapKit

class EmployeeListViewController: UIViewController, ViewControllerProtocol {
    lazy var tableView: UITableView = UITableView(frame: .zero, style: .grouped)
    private var cancellables = Set<AnyCancellable>()
    private var viewModel: EmployeeListViewModel
    var dataSource: EmployeeListDataSource? {
        didSet {
            setTableViewDataSourceAndReload()
        }
    }
    
    init(viewModel: EmployeeListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupGUI()
        setupViewModel()
        loadData()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
        
    //  MARK: - Setup GUI
    func setupGUI() {
        title = viewModel.title
        setupNavigationBar()
        setupNavigationBarItems()
        setupBackground()
        setupTableView()
        setupConstraints()
    }
    
    //  MARK: - Table view (list)
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = AppUI.defaultBgColor
        tableView.separatorColor = AppUI.separatorColor
        tableView.delegate = self
        setupTableViewCell()
    }
    
    private func setupTableViewCell() {
        tableView.register(EmployeeListCell.self, forCellReuseIdentifier: EmployeeListCell.reuseIdentifier)
        tableView.estimatedRowHeight = EmployeeListCell.estimatedHeight
        tableView.rowHeight = UITableView.automaticDimension
    }
        
    private func setTableViewDataSourceAndReload() {
        tableView.dataSource = dataSource
        tableView.reloadData()
    }
    
    private func loadData() {
        viewModel.loadData()
        dataSource = EmployeeListDataSource(viewModel: viewModel)
    }
}


//  MARK: - Constraints
private extension EmployeeListViewController {
    func setupConstraints() {
        setupTableViewConstraints()
    }
    
    func setupTableViewConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
}

    
//  MARK: - View model, callbacks
private extension EmployeeListViewController {
    func setupViewModel() {
        handleLoadingStatusUpdated()
        handleFailurePublisher()
        handleShouldReloadDataPublisher()
    }

    func handleFailurePublisher() {
        viewModel.failure.sink { [weak self] (error) in
            guard let weakSelf = self else { return }
            weakSelf.handleError(error)
        }.store(in: &cancellables)
    }

    private func handleShouldReloadDataPublisher() {
        viewModel.shouldReloadData.sink { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.title = weakSelf.viewModel.title
            weakSelf.tableView.reloadData()
            weakSelf.tableView.isHidden = false
        }.store(in: &cancellables)
    }

    func handleLoadingStatusUpdated() {
        viewModel.loadingStatusUpdated.sink { [weak self] (isLoading) in
            guard let weakSelf = self else { return }
            DispatchQueue.main.async {
                weakSelf.tableView.isHidden = isLoading
                isLoading ? weakSelf.showActivityIndicator() : weakSelf.hideActivityIndicator()
            }
        }.store(in: &cancellables)
    }
}


//  MARK: - UITableViewDelegate
extension EmployeeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.userSelectedRow(index: indexPath.row)
    }    
}



