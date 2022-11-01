//
//  ViewController.swift
//  AvitoInternTest
//
//  Created by Dilshodi Kahori on 27/10/22.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    
    // MARK: - Data Layer
    var employees: [Organization.Employee] = []
    
    // MARK: - UI
    private lazy var refreshControl: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refresher
    }()
    
    private lazy var errorView: ErrorPlaceholderView = {
        let errorView = ErrorPlaceholderView()
        errorView.backgroundColor = .white
        errorView.onClick = {
            self.getEmployeeList()
        }
        return errorView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(EmployeeTableViewCell.self, forCellReuseIdentifier: "employeeCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.refreshControl = self.refreshControl
        return tableView
    }()
    
    // MARK: - Actions
    @objc
    private func handleRefresh() {
        refreshControl.beginRefreshing()
        self.getEmployeeList()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.30) {
            self.refreshControl.endRefreshing()
        }
    }
    
    // MARK: - Lifecycle
    private func setupUI() {
        view.addSubview(errorView)
        view.addSubview(tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        makeConstraints()
        getEmployeeList()
    }
    
    // MARK: - Fetch JSON
    private func getEmployeeList() {
        let networkManager = AvitoAPI()
        guard let url = URL(string: "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c") else {
            fatalError()
        }
        
        networkManager.requestData(fromURL: url) { (result: Result<Organization, Error>) in
            switch result {
            case .success(let success):
                self.errorView.isHidden = true
                self.employees = success.company.employees
            case .failure(let failure):
                self.tableView.isHidden = true
                self.errorView.errorTitle.text = "Error Occured"
                self.errorView.errorMessage.text = failure.localizedDescription
            }
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Constraints
    private func makeConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        errorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "employeeCell", for: indexPath)
        if let cell = cell as? EmployeeTableViewCell {
            let sortedEmployee = employees.sorted { ($0.name < $1.name)}
            cell.content = sortedEmployee[indexPath.row]
        }
        return cell
    }
}

