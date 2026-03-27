//
//  UILabelExtension.swift
//  CalendarMain
//
//  Created by Artiom on 20.01.26.
//

import UIKit


extension UILabel {
    static func createLabel(text: String = "", NOL: Int = 0, textColor: UIColor = Resources.Colors.labelColor, isHidden: Bool = false) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.numberOfLines = NOL
        label.isHidden = isHidden
        return label
    }
}


extension UILabel {
    static func createInfoLabel(text: String = "") -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .label
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }
}
