//
//  SplashVC.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

import UIKit

class SplashVC: UIViewController {
    
    private let animationView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGreen
        view.layer.cornerRadius = 32
        return view
    }()
    
    var onCompletion: CompletionBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateLogo()
    }
    
    private func configureUI() {
        view.addSubview(animationView)
        animationView.centerInSuperview(size: .init(width: 64, height: 64))
        animationView.transform = CGAffineTransform(scaleX: 0, y: 0)
    }
    
    private func animateLogo() {
        UIView.animate(withDuration: 1.0, delay: 0.5, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.animationView.transform = .identity
        } completion: { [weak self] _ in
            guard let self else { return }
            onCompletion?()
        }
    }
}
