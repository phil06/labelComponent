//
//  OrderedItemLabelView.swift
//  LabelComponent
//
//  Created by NHNEnt on 24/04/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import UIKit

class ItemLabelView: UIView {
    
    var keyLabel: UILabel!
    var valueLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initLayout()
    }
    
    private func initLayout() {
        keyLabel = UILabel()
        keyLabel.numberOfLines = 0
        addSubview(keyLabel)
        keyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        valueLabel = UILabel()
        valueLabel.numberOfLines = 0
        addSubview(valueLabel)
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setLayout(inset: UIEdgeInsets, attributes: [NSAttributedString.Key: Any], spacing: CGFloat, data: ItemLabelData) {
        if data.key != nil {
            keyLabel.attributedText = NSMutableAttributedString(string: data.key!, attributes: data.keyAttributes ?? attributes)
        }
        valueLabel.attributedText = NSMutableAttributedString(string: data.val, attributes: data.valAttributes ?? attributes)
        
        let metrics = [
            "top": inset.top,
            "left": inset.left,
            "right": inset.right,
            "bottom": inset.bottom,
            "spacing": spacing
        ]
        
        let constraint_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[valueLabel]-bottom-|", metrics: metrics, views: ["valueLabel": valueLabel])
        let constraint_H: [NSLayoutConstraint]
        if data.key != nil {
            constraint_H =
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-left-[keyLabel]-spacing-[valueLabel]-right-|", options: .alignAllTop, metrics: metrics, views: ["keyLabel": keyLabel, "valueLabel": valueLabel])
        } else {
            constraint_H =
                NSLayoutConstraint.constraints(withVisualFormat: "H:|-left-[valueLabel]-right-|", metrics: metrics, views: ["valueLabel": valueLabel])
        }
        
        NSLayoutConstraint.activate(constraint_V + constraint_H)
        
        updateConstraints()
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
