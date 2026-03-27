//
//  PrimaryButton.swift
//  CalendarMain
//
//  Created by Artiom on 22.01.26.
//

import UIKit


class PrimaryButton: UIButton {
    
    
    init(title: String = "") {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        self.backgroundColor = Resources.Colors.mainGreenActive
        self.setTitleColor(.black, for: .normal)
        self.layer.cornerRadius = 8
        titleLabel?.font = .boldSystemFont(ofSize: 16)
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        

    }
}
//
//
//final class PrimaryButton: UIButton {
//    
//    private let gradientLayer = CAGradientLayer()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupButton()
////        setupGradient()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupButton() {
//        setTitleColor(.black, for: .normal)
//        titleLabel?.font = .boldSystemFont(ofSize: 16)
//        
//        layer.cornerRadius = 8
//        layer.borderColor = UIColor.black.cgColor
//        layer.borderWidth = 1
//        layer.masksToBounds = true
//    }
//    
//    private func setupGradient() {
//        gradientLayer.colors = [
//            UIColor.systemGreen.cgColor,
//            UIColor.systemPurple.cgColor
//        ]
//        
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5) // слева
//        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)   // направо
//        
//        layer.insertSublayer(gradientLayer, at: 0)
//    }
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
////        gradientLayer.frame = bounds
//    }
//}
