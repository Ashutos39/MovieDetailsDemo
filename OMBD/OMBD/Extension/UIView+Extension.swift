//
//  UIView+Extension.swift
//  OMBD
//
//  Created by Ashutos Sahoo on 22/08/22.
//

import UIKit

extension UIView {
    
    func addCornerRadius(withRadius cornerRadius: CGFloat) {
        clipsToBounds = true
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
    }
}
