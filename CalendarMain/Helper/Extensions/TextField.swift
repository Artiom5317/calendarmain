//
//  TextField.swift
//  CalendarMain
//
//  Created by Artiom on 22.01.26.
//
import UIKit

//
//extension UITextField {
//    
//    static func createTextField(placeHolder: String) -> UITextField {
//        let tf = UITextField()
//        tf.placeholder = placeHolder
//        tf.leftView = .init(frame: .init(x: 0, y: 0, width: 15, height: 0))
//        tf.leftViewMode = .always
//        tf.layer.borderColor = UIColor.black.cgColor
//        tf.layer.borderWidth = 1
//        tf.layer.cornerRadius = 8
//        tf.clipsToBounds = true
//        return tf
//    }
//}

extension UITextField {
    static func createTextField(placeHolder: String) -> UITextField {
        let tf = UITextField()
        tf.placeholder = placeHolder
        tf.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        tf.leftViewMode = .always
        
        // Фиксим проблему с border
        let pixelWidth = 2.0 / UIScreen.main.scale
        tf.layer.borderWidth = pixelWidth
//        tf.layer.borderColor = UIColor.separator.cgColor // Адаптивный цвет
        tf.layer.borderColor = UIColor.black.cgColor // Адаптивный цвет
        
        tf.layer.cornerRadius = 8
        tf.clipsToBounds = true
        return tf
    }
}
