//
//  Extensions+UITextView.swift
//  ITRootsTask
//
//  Created by Saad Sherif on 19/01/2025.
//

import UIKit

//MARK:- Localization
extension UITextView {
    open override func awakeFromNib() {
        super.awakeFromNib()
        if Language.isRTL() {
            if textAlignment == .natural {
                self.textAlignment = .right
            }
        } else {
            if textAlignment == .natural {
                self.textAlignment = .left
            }
        }
    }
}
