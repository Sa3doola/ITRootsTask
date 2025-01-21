//
//  ErrorView.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//


import UIKit

public class ErrorView: NiblessView {
    
    lazy var mainStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageView, messageLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = 24
        return stack
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "wifi.slash")
        return imageView
    }()
    
    public let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    var retry: CompletionBlock?
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        constructHierarchy()
        activateConstraints()
        configureViews()
    }
    
    private func configureViews() {
        backgroundColor = .clear
    }
    
    private func constructHierarchy() {
        addSubview(mainStackView)
    }
    
    private func activateConstraints() {
        activateConstraintsForStackView()
    }
    
    private func activateConstraintsForStackView() {
        mainStackView.centerXInSuperview()
        mainStackView.centerYInSuperview()
        imageView.constrainHeight(constant: 256)
    }
}
