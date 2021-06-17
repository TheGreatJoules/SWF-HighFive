//
//  MyTextField.swift
//  SeniorDesign
//
//  Created by Julian Carachure on 2/25/18.
//  Copyright © 2018 Julian Carachure. All rights reserved.
//

import UIKit

@IBDesignable class MyTextField: UITextField,UITextFieldDelegate{

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        delegate = self
        createBottomBorder()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
        createBottomBorder()
    }
    
    func createBottomBorder(){
        self.borderStyle = UITextBorderStyle.none
        self.backgroundColor = UIColor.clear
//        let border = UIView()
//        let height = 1.0
//        let borderColor = UIColor(red: 55/255, green: 78/255, blue: 95/255, alpha: 1.0)
//        border.frame = CGRect(x: 0,
//                              y: Double(self.frame.size.height) - height,
//                              width: Double(self.frame.size.width),
//                              height: height)
//        border.backgroundColor = borderColor
//        self.addSubview(border)
//        self.layer.masksToBounds = true
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.lightGray.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
}
