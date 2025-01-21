//
//  Retryable.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//


import UIKit

public protocol Retryable {
    
    func showMessageView(with message: String?, errorHandler: @escaping () -> Void)
    
    func hideMessageView()
}

// MARK: - UIViewController

public extension Retryable where Self: UIViewController {
    
    func showMessageView(with message: String?,
                         errorHandler: @escaping CompletionBlock) {
        let messageView = ErrorView()
        messageView.messageLabel.text = message
        messageView.retry = errorHandler
        
        view.addSubview(messageView)
        messageView.anchor(
            top: nil,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 0, left: 16, bottom: 0, right: 16)
        )
        messageView.centerYInSuperview()
        messageView.tag = ConstantsPresentable.presentableViewTag
    }
    
    func hideMessageView() {
        view.subviews.forEach { subview in
            if subview.tag == ConstantsPresentable.presentableViewTag {
                subview.removeFromSuperview()
            }
        }
    }
}

// MARK: - ConstantsLoadable
private struct ConstantsPresentable {
    fileprivate static let presentableViewTag = 1235
}
