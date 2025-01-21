//
//  HomeViewModel.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

import Combine

protocol UsersViewModelProtocol {
    
    var cancellables: Cancellables { get set }
    var scheduler: Scheduler { get }
    
    var users: CurrentValueSubject<[UserElement], Never> { get }
    var viewState: PassthroughSubject<GeneralViewState, Never> { get }
    func viewDidLoad()
}

final class UsersViewModel: UsersViewModelProtocol  {
    
    var users = CurrentValueSubject<[UserElement], Never>([])
    var viewState = PassthroughSubject<GeneralViewState, Never>()
    
    var scheduler: Scheduler = .main
    var cancellables = Cancellables()
    
    private let repository: UserRepositoryProtocol
    private weak var coordinator: UserCoordinatorProtocol?
    
    init(repository: UserRepositoryProtocol,
         coordinator: UserCoordinatorProtocol) {
        self.repository = repository
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        repository.callUserAPI()
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
                guard let self else { return }
                users.send(response)
            }.store(in: &cancellables)
    }

}

