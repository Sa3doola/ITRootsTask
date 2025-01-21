//
//  HomeViewModel.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

protocol MapViewModelProtocol {
    func viewDidLoad()
}

final class MapViewModel: MapViewModelProtocol  {
    

    private weak var coordinator: MapCoordinatorProtocol?
    
    init(coordinator: MapCoordinatorProtocol) {
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        
    }

}

