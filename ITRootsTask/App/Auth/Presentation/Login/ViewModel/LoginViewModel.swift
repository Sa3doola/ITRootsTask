//
//  LoginViewModel.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

import Combine

protocol LoginViewModelProtocol {
    
    // MARK: - Input -
    
    var cancellables: Cancellables { get set }
    func viewDidLoad()
    
    var textPhoneSubject: CurrentValueSubject<String ,Never> { get set }
    var textPasswordSubject: CurrentValueSubject<String ,Never> { get set }
    
    func validateLogin()
    func goToRegister()
    
    // MARK: - OutPut -
    
    var viewState: PassthroughSubject<GeneralViewState, Never> { get }
    
}



final class LoginViewModel: ObservableObject, LoginViewModelProtocol {
    
    // MARK: - Properites -
    
    var textPhoneSubject: CurrentValueSubject<String, Never> = CurrentValueSubject<String,Never>("")
    var textPasswordSubject: CurrentValueSubject<String, Never> = CurrentValueSubject<String,Never>("")
    var viewState =  PassthroughSubject<GeneralViewState, Never>()
    
    var scheduler: Scheduler = .main
    
    var cancellables = Cancellables()
    var loginCredentials = LoginCredentials()
    
    private let useCase: LoginUseCaseProtocol
    weak var coordinator: AuthCoordinatorProtocol?
    
    // MARK: - Properites -

    init(useCase: LoginUseCaseProtocol,
         
         coordinator: AuthCoordinatorProtocol) {
        self.useCase = useCase
        self.coordinator = coordinator
    }

    deinit {
        print("LoginViewModel is deinit, No memory leak found")
    }
    
    func viewDidLoad() {
        textPhoneSubject.sinkOnMain { [weak self] text in
            guard let self else { return }
            loginCredentials.phone = text
        }.store(in: &cancellables)
        
        textPhoneSubject.sinkOnMain { [weak self] text in
            guard let self else { return }
            loginCredentials.phone = text
        }.store(in: &cancellables)
 
    }
    

    func validateLogin() {
        viewState.send(.loading)
        useCase.sendLogin(loginCredentials)
            .receive(on: scheduler)
            .sink { [weak self] completion in
                guard let self  else {return}
                switch completion {
                case .finished:
                    print("Send Login Event is => finished 😁")
                    viewState.send(.initial)
                case .failure(let error):
                    viewState.send(.initial)
                    viewState.send(.error(message: error.localizedDescription))
                }
            } receiveValue: { [weak self] responce in
                guard let self  else {return}
                guard let data  = responce.data else {return}
                coordinator?.navigate(to: .goToHome)
            }.store(in: &cancellables)
    }
    
    func goToRegister() {
        coordinator?.navigate(to: .goToRegister)
    }
}
