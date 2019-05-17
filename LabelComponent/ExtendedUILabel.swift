//
//  ExtendedUILabel.swift
//  LabelComponent
//
//  Created by NHNEnt on 30/04/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation

public class ExtendedUILabel: UILabel {
    public var inset = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    public var layerBorderColor = UIColor.black
    public var layerBorderWidth:CGFloat = 0
    
    public override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: inset)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -inset.top,
                                          left: -inset.left,
                                          bottom: -inset.bottom,
                                          right: -inset.right)
        return textRect.inset(by: invertedInsets)
    }
    
    public override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: inset))
    }
    
    public override func draw(_ rect: CGRect) {
        
        super.draw(rect)
        
        if layerBorderWidth > 0 {

            let newRect = CGRect(x: 0, y: 0,
                                 width: rect.size.width + (rect.origin.x * 2 ) - layerBorderWidth,
                                 height: rect.size.height + (rect.origin.y * 2 ) - layerBorderWidth )
            
            let path = UIBezierPath(rect: newRect)

            path.lineWidth = layerBorderWidth
            layerBorderColor.setStroke()
            
            path.stroke()
            path.close()
        }
    }
    

}


