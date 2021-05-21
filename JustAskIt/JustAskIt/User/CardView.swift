//
//  CardView.swift
//  JustAskIt
//
//  Created by Ufuk Angay on 20/05/2021.
//

import UIKit

@IBDesignable class CardView: UIView {

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    
    @IBInspectable var cornerradius : CGFloat = 15
    @IBInspectable var shadowOffSetWidth : CGFloat = 0
    @IBInspectable var shadowOffSetHeight : CGFloat = 0
    @IBInspectable var shadowColor : UIColor = UIColor.black
    @IBInspectable var shadowOpacity : CGFloat = 0.2
    
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerradius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerradius)
        
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
    }
    
}
