//
//  OrderedItemLabelView.swift
//  LabelComponent
//
//  Created by NHNEnt on 24/04/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import UIKit

public class OrderedItemLabelView: UIView {
    
    var stackView: UIStackView!
    var views: [UIView] = []
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func setLayout(data: [ItemLabelData],
                   spacing: CGFloat,
                   inset: UIEdgeInsets,
                   outterInset: UIEdgeInsets,
                   defaultAttributes: [NSAttributedString.Key: Any]) {
        
        data.forEach { (dat) in
            let view = ItemLabelView(frame: self.bounds)
            view.setLayout(inset: inset, attributes: defaultAttributes, spacing: spacing, data: dat)
            views.append(view)
        }
        
        stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 0
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let metrics:[String: Any] = ["top": outterInset.top,
                                     "left": outterInset.left,
                                     "right": outterInset.right,
                                     "bottom": outterInset.bottom]
        
        let viewsDictionary:[String : Any] = ["stackView":stackView]
        let stackView_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-left-[stackView]-right-|",
                                                         options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                         metrics: metrics,
                                                         views: viewsDictionary)
        let stackView_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-top-[stackView]-bottom-|",
                                                         options: NSLayoutConstraint.FormatOptions(rawValue:0),
                                                         metrics: metrics,
                                                         views: viewsDictionary)
        
        NSLayoutConstraint.activate(stackView_H + stackView_V)
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
