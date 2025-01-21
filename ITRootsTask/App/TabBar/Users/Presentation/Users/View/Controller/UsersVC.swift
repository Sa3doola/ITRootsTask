//
//  MapVC.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

import UIKit

class UsersVC: UIViewController, Emptiable, Retryable {
    
    // MARK: - Properties -
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties -
    
    private var viewModel: UsersViewModelProtocol!
    
    // MARK: - Init -
    
    init(viewModel: UsersViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: "UsersVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
}

// MARK: - Configuration -

extension UsersVC {
    
    private func configuration() {
        configureUI()
        configureTable()
    }
    
    private func configureUI() {
        navigationItem.title = "Users_Navigation_Title".localized
    }
    
    private func configureTable() {
        tableView.register(cellType: UserTableCell.self)
        tableView.dataSource = self
    }
}

// MARK: - Life Cycle -

extension UsersVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: UserTableCell.self, for: indexPath)
        return cell
    }
}
