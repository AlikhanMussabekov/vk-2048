//
// Created by Alikhan Nurlanovich on 2019-05-09.
// Copyright (c) 2019 Chainless. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    func fillSuperView(){
        translatesAutoresizingMaskIntoConstraints = false

        guard let superview = superview else {return}

        topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superview.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superview.trailingAnchor).isActive = true
    }

    func anchor(top: NSLayoutYAxisAnchor?,
                leading: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero) {

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }

        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }

        if let bottom = bottom{
            bottomAnchor.constraint(equalTo: bottom, constant: padding.bottom).isActive = true
        }

        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: padding.right).isActive = true
        }

        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }

        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }

    func centerInSuperview(
        centerX: NSLayoutXAxisAnchor?,
        centerY: NSLayoutYAxisAnchor?,
        size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false

        if let centerX = centerX{
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }
        
        if let centerY = centerY{
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }

    }

}
