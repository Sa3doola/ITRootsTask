//
//  HomeViewModel.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

protocol HomeViewModelProtocol {
    var homeData: [HomeEntity] { get set }
    func viewDidLoad()
}

final class HomeViewModel: HomeViewModelProtocol  {
    
    private let repository: HomeRepositoryProtocol
    private weak var coordinator: HomeCoordinatorProtocol?
    
    var homeData = [HomeEntity]()
    
    init(repository: HomeRepositoryProtocol,
         coordinator: HomeCoordinatorProtocol) {
        self.repository = repository
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        homeData = repository.createHomeData()
    }
}

