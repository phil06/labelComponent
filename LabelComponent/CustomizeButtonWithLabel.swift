//
//  CutomizeButtonWithLabel.swift
//  LabelComponent
//
//  Created by NHNEnt on 21/06/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation

public class CustomizeButtonWithLabel: UIView {
    
    public var identifier: String!
    public weak var delegate: CustomizeButtonWithLabelDelegate?

    var button: UIButton!
    var label: UILabel!
    
    var constraintsV: [NSLayoutConstraint] = []
    var constraintsH: [NSLayoutConstraint] = []
    
    var buttonSize: CGSize!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initAction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initAction()
    }
    
    public override func sizeToFit() {
        super.sizeToFit()
        layoutView()
    }
    
    private func initAction() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonTap))
        tapGesture.cancelsTouchesInView = false
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
    
    @objc private func buttonTap() {
        delegate?.buttonTapped(identifier: identifier ?? "")
    }
    
    
    public func setButtonImage(with: String, size: CGSize = CGSize.zero) {
        buttonSize = size
        
        button = UIButton()
        button.setImage(UIImage(named: with), for: .normal)
        button.setImage(UIImage(named: with), for: .highlighted)
        button.setImage(UIImage(named: with), for: .selected)
        if button.superview != nil {
            button.removeFromSuperview()
        }

        addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func setButtonBackground(color: UIColor, radius: CGFloat) {
        button.layer.backgroundColor = color.cgColor
        button.layer.cornerRadius = radius
        button.clipsToBounds = true
    }
    
    public func setLabelAttributes(txt: String, attr: [NSAttributedString.Key: Any]) {
        label = UILabel()
        label.attributedText = NSMutableAttributedString(string: txt, attributes: attr)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layoutView() {
        
        if constraintsV.count > 0 {
            NSLayoutConstraint.deactivate(constraintsV)
            constraintsV.removeAll()
        }

        if constraintsH.count > 0 {
            NSLayoutConstraint.deactivate(constraintsH)
            constraintsH.removeAll()
        }
        
        guard button != nil || label != nil else {
            return
        }
        
        var views: [String:UIView] = [:]
        views["button"] = button
        views["label"] = label
        
        let labelHConstraint = label != nil ? "-10-[label]-0-|" : ""
        let labelVConstraint = label != nil ? "[label]" : ""
        var buttonHConstraint = ""
        var buttonVConstraint = ""
        var metrics:[String : Any] = [:]
        
        if button != nil {
            button.sizeToFit()
            
            buttonHConstraint = "-0-[button(buttonW)]"
            buttonVConstraint = "[button(buttonH)]"
            
            metrics = [
                "buttonW": buttonSize == CGSize.zero ? button.bounds.size.width : buttonSize.width,
                "buttonH": buttonSize == CGSize.zero ? button.bounds.size.height : buttonSize.height]
        }
        
        let HConst = String.init(format: "H:|%@%@", buttonHConstraint, labelHConstraint)
        let VConst = String.init(format: "V:|-0-%@-0-|", button != nil ? buttonVConstraint : labelVConstraint)
        
        constraintsH += NSLayoutConstraint.constraints(withVisualFormat: HConst, options: .alignAllCenterY , metrics: metrics, views: views)
        constraintsV += NSLayoutConstraint.constraints(withVisualFormat: VConst, metrics: metrics, views: views)
        
        NSLayoutConstraint.activate(constraintsV + constraintsH)
        updateConstraints()
    }
}

public protocol CustomizeButtonWithLabelDelegate: NSObject {
    func buttonTapped(identifier: String)
}
