//
//  LabelView.swift
//  LabelComponent
//
//  Created by NHNEnt on 10/05/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import UIKit

class LabelView: UIView {
    
    var label: ExtendedUILabel!
    var ratio: CGFloat! = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initLayout()
    }
    
    private func initLayout() {
        label = ExtendedUILabel()
        label.textAlignment = .center
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[label]-0-|",
                                                         metrics: nil,
                                                         views: ["label": label])
        let stackView_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[label]-0-|",
                                                         metrics: nil,
                                                         views: ["label": label])
        
        NSLayoutConstraint.activate(stackView_H + stackView_V)
    }
    
    func setLayout(inset: UIEdgeInsets?, attr: NSMutableAttributedString, bgColor: UIColor) {
        label.inset = inset ?? UIEdgeInsets.zero
        label.attributedText = attr
        label.backgroundColor = bgColor
    }
    
    func activeLayerBorder(color: UIColor, width: CGFloat) {
        label.layerBorderColor = color
        label.layerBorderWidth = width
    }
    
    override var intrinsicContentSize: CGSize {
        if ratio > 0 {
            debugPrint("intrinsicContentSize > \(CGSize(width: ratio, height: 1.0))")
            return CGSize(width: ratio, height: 1.0)
        } else {
            debugPrint("intrinsicContentSize > \(CGSize(width: 1.0, height: 1.0))")
            return CGSize(width: 1.0, height: 1.0)
        }
    }

}
