//
//  Emptiable.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

import UIKit

public protocol Emptiable {
    
    func showEmptyView(with message: String?)
    
    func hideEmptyView()
}

// MARK: - UIViewController
public extension Emptiable where Self: UIViewController {
    
    func showEmptyView(with message: String?) {
        let emptyView = EmptyView()
        emptyView.messageLabel.text = message
        view.addSubview(emptyView)
        emptyView.anchor(
            top: nil,
            leading: self.view.leadingAnchor,
            bottom: nil,
            trailing: self.view.trailingAnchor,
            padding: .init(top: 0, left: 16, bottom: 0, right: 16)
        )
        emptyView.centerYInSuperview()
        emptyView.tag = ConstansEmptiable.emptyViewTag
    }
    
    func hideEmptyView() {
        view.subviews.forEach { subView in
            if subView.tag == ConstansEmptiable.emptyViewTag {
                subView.removeFromSuperview()
            }
        }
    }
}

// MARK: - Constans Emptiable
private struct ConstansEmptiable {
    fileprivate static let emptyViewTag = 4321
}
