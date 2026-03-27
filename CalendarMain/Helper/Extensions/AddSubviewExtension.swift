//
//  AddSubviewExtension.swift
//  CalendarMain
//
//  Created by Artiom on 20.01.26.
//

import UIKit


extension UIView {
    
    func addSubviews(_ views:UIView...) {
        views.forEach { view in
            self.addSubview(view)
        }
    }
    
    func disableTamic() {
        self.subviews.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
}
