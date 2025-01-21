//
//  LoginVC.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

import UIKit

class LoginVC: UIViewController {

    // MARK: - Properties -
    
    var viewModel: LoginViewModelProtocol!
    
    // MARK: - init -
    
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: "LoginVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        configuration()
    }
}
