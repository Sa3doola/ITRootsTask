//
//  HomeVC.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Properties -
    
    private var viewModel: HomeViewModelProtocol!
    
    // MARK: - Init -
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: "HomeVC", bundle: nil)
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

extension HomeVC {
    
    private func configuration() {
        configureUI()
        configureCollection()
    }
    
    private func configureUI() {
        self.navigationItem.title = "Home_Navigation_title".localized
        viewModel.viewDidLoad()
    }
    
    private func configureCollection() {
        let cells = [StoreCollectionCell.self, ProductCollectionCell.self]
        collectionView.register(cellTypes: cells)
        collectionView.dataSource = self
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) in
            AppLayout.shared.createHomeLayoutSections(model: self.viewModel.homeData, index: sectionIndex)
        }
        return layout
    }
}

// MARK: - UICollectionViewDataSource -

extension HomeVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.homeData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.homeData[section].numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch viewModel.homeData[indexPath.section] {

        case .stores(let stores):
            let cell = collectionView.dequeueReusableCell(with: StoreCollectionCell.self, for: indexPath)
            cell.backgroundColor = .green
            return cell
        case .productts(let products):
            let cell = collectionView.dequeueReusableCell(with: ProductCollectionCell.self, for: indexPath)
            cell.backgroundColor = .brown
            return cell
        }
    }
}
