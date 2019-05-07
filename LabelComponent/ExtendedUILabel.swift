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

}
