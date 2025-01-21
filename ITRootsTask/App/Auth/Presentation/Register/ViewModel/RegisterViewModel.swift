//
//  RegisterViewModel.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

import Combine

protocol RegisterViewModelProtocol {
    
    // MARK: - Input -
    
    var cancellables: Cancellables { get set }
    var scheduler: Scheduler { get }
    
    var textFullNameSubject : CurrentValueSubject<String ,Never> { get set }
    var textUserNameSubject : CurrentValueSubject<String ,Never> { get set }
    var textPasswordSubject: CurrentValueSubject<String,Never> { get set }
    var textEmailSubject: CurrentValueSubject<String,Never> { get set }
    var textPhoneSubject : CurrentValueSubject<String ,Never> { get set }
    
    func validateData()
    
    // MARK: - Output -
    
    func viewDidLoad()
    var viewState: PassthroughSubject<GeneralViewState, Never> { get }
}

class RegisterViewModel: RegisterViewModelProtocol {
    
    // MARK: - Properites -
    
    var textFullNameSubject = CurrentValueSubject<String, Never>("")
    var textUserNameSubject = CurrentValueSubject<String,Never>("")
    var textPasswordSubject = CurrentValueSubject<String,Never>("")
    var textEmailSubject = CurrentValueSubject<String,Never>("")
    var textPhoneSubject = CurrentValueSubject<String,Never>("")
    var viewState = PassthroughSubject<GeneralViewState, Never>()
    
    var scheduler: Scheduler = .main
    var cancellables = Cancellables()
    
    
    var registerModel = RegisterModel()
    
    private let useCase: RegisterUseCaseProtocol
    private weak var coordinator: AuthCoordinatorProtocol?
    
    // MARK: - Init -
    
    init(useCase: RegisterUseCaseProtocol,
         coordinator: AuthCoordinatorProtocol) {
        self.useCase = useCase
        self.coordinator = coordinator
    }
    
    deinit {
        print("NewAccountViewModel is deinit, No memory leak found")
    }
    
    // MARK: - Init -
    
    func viewDidLoad() {
        bindInputData()
    }

    func validateData() {
        viewState.send(.loading)
        useCase.exexuteRegister(registerModel)
            .receive(on: scheduler)
            .sink { [weak self] completion in
                guard let self  else {return}
                switch completion {
                case .finished:
                    print("Send Register Event is => finished 😁")
                    viewState.send(.initial)
                case .failure(let error):
                    viewState.send(.initial)
                    viewState.send(.error(message: error.localizedDescription))
                }
            } receiveValue: { [weak self] response in
                guard let self  else {return}
                guard let data = response.data else {return}
                
            }.store(in: &cancellables)
    }
}

extension RegisterViewModel {
   
    private func bindInputData() {
        textFullNameSubject.sinkOnMain { [weak self] text in
            guard let self else { return }
            self.registerModel.fullname = text
        }.store(in: &cancellables)
        textUserNameSubject.sinkOnMain { [weak self] text in
            guard let self else { return }
            self.registerModel.userName = text
        }.store(in: &cancellables)
        textPasswordSubject.sinkOnMain { [weak self] text in
            guard let self else { return }
            self.registerModel.password = text
        }.store(in: &cancellables)
        textEmailSubject.sinkOnMain { [weak self] text in
            guard let self else { return }
            self.registerModel.email = text
        }.store(in: &cancellables)
        textPhoneSubject.sinkOnMain { [weak self] location in
            guard let self else { return }
            self.registerModel.phone = location
        }.store(in: &cancellables)
    }
}

// MARK: - Router -

extension RegisterViewModel {
    
    func goToHome() {
        coordinator?.navigate(to: .goToHome)
    }
}
