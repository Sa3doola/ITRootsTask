//
//  MapVC.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

import UIKit
import MapKit

class MapVC: UIViewController {

    @IBOutlet private weak var mapView: MKMapView!
    
    // MARK: - Properties -
    
    private var viewModel: MapViewModelProtocol!
    
    // MARK: - Init -
    
    init(viewModel: MapViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: "MapVC", bundle: nil)
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

extension MapVC {
    
    private func configuration() {
        configureUI()
    }
    
    private func configureUI() {
        
    }
}
