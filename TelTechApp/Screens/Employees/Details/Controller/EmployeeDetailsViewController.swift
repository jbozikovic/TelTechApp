//
//  EmployeeDetailsViewController.swift
//  TelTechApp
//
//  Created by Jurica Bozikovic on 02.04.2023..
//  Copyright © 2023 CocodeLab. All rights reserved.
//

import UIKit
import Combine
import SnapKit

class EmployeeDetailsViewController: UIViewController, ViewControllerProtocol {
    lazy var tableView: UITableView = UITableView(frame: .zero, style: .grouped)
        
    private var cancellables = Set<AnyCancellable>()
    private var viewModel: EmployeeDetailsViewModel
    var dataSource: EmployeeDetailsDataSource? {
        didSet {
            setTableViewDataSourceAndReload()
        }
    }

    init(viewModel: EmployeeDetailsViewModel) {
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
        tableView.backgroundColor = .clear//AppUI.defaultBgColor
        tableView.delegate = self
        setupTableViewCell()
        setupTableViewHeader()
    }

    private func setupTableViewCell() {
        tableView.register(EmployeeDetailsCell.self, forCellReuseIdentifier: EmployeeDetailsCell.reuseIdentifier)
        tableView.estimatedRowHeight = EmployeeDetailsCell.estimatedHeight
        tableView.rowHeight = UITableView.automaticDimension
    }

    private func setupTableViewHeader() {
        tableView.register(EmployeeDetailsHeaderView.self, forHeaderFooterViewReuseIdentifier: EmployeeDetailsHeaderView.reuseIdentifier)
        tableView.estimatedSectionHeaderHeight = EmployeeDetailsHeaderView.estimatedHeight
        tableView.sectionHeaderHeight = UITableView.automaticDimension
    }
        
    private func setTableViewDataSourceAndReload() {
        tableView.dataSource = dataSource
        tableView.reloadData()
    }

    private func loadData() {
        self.dataSource = EmployeeDetailsDataSource(viewModel: viewModel)
    }
}


//  MARK: - Constraints
private extension EmployeeDetailsViewController {
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
private extension EmployeeDetailsViewController {
    func setupViewModel() {
        handleShouldReloadDataPublisher()
    }
    
    private func handleShouldReloadDataPublisher() {
        viewModel.shouldReloadData.sink { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.title = weakSelf.viewModel.title
            weakSelf.tableView.reloadData()
            weakSelf.tableView.isHidden = false
        }.store(in: &cancellables)
    }
}


//  MARK: - UITableViewDelegate
extension EmployeeDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: EmployeeDetailsHeaderView.reuseIdentifier) as? EmployeeDetailsHeaderView else { return nil }
        if let vm = viewModel.haederViewModel {
            headerView.configure(vm)
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension // EmployeeDetailsHeaderView.estimatedHeight
    }
}



