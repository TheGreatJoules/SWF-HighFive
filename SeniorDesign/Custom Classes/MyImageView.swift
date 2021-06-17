//
//  MyImageView.swift
//  SeniorDesign
//
//  Created by Julian Carachure on 2/25/18.
//  Copyright © 2018 Julian Carachure. All rights reserved.
//
import UIKit

@IBDesignable
class MyImageView: UIImageView {
    @IBInspectable var borderColor: UIColor? = DefaultValues.borderColor{
        didSet {
            layer.borderColor = self.borderColor?.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = DefaultValues.borderWidth {
        didSet {
            layer.borderWidth = self.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = DefaultValues.cornerRadius {
        didSet {
            layer.cornerRadius = self.cornerRadius
            layer.masksToBounds = self.cornerRadius > 0
            
            
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = self.cornerRadius
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor?.cgColor
    }
    
    private struct DefaultValues{
        static let cornerRadius: CGFloat = 8.0
        static let borderWidth: CGFloat = 2.0
        static let borderColor: UIColor = UIColor.clear
    }
}
