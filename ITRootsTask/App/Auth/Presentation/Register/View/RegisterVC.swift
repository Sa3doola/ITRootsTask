//
//  RegisterVC.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

import UIKit

class RegisterVC: UIViewController {

//    @IBOutlet private weak var fullNameTextFieldView: GeneralFieldView!
//    @IBOutlet private weak var userNameTextFieldView: GeneralFieldView!
//    @IBOutlet private weak var phoneTextFieldView: GeneralFieldView!
//    @IBOutlet private weak var passwordTextFieldView: GeneralFieldView!
//    @IBOutlet private weak var emailTextFieldView: GeneralFieldView!
    
    @IBOutlet private weak var registerBtn: UIButton!
    
    // MARK: - Properties -
    
    var viewModel: RegisterViewModelProtocol!
    
    // MARK: - Init -
    
    init(viewModel: RegisterViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: "RegisterVC", bundle: nil)
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
