//
//  LabelButtonView.swift
//  LabelComponent
//
//  Created by NHNEnt on 15/05/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import UIKit

/*
 한 뷰에서 여러개 사용할경우엔 tag 로 구분해야함........
 */
public class LabelButtonView: UIView {
    
    var checkbox: UIButton!
    public var desc: UILabel!
    public var additionalButton: UIButton!
    
    public var containerInset: UIEdgeInsets = UIEdgeInsets.zero
    public var checkboxSpace: CGFloat = 0
    public var checkboxSelectedTextColor: UIColor!
    private var checkboxDeselectTextColor: UIColor!
    public var additionalButtonSpace: CGFloat = 0
    var autoLayoutConstraints: [NSLayoutConstraint] = []
    
    public weak var delegate: LabelButtonViewDelegate?

    public override init(frame: CGRect) {
        super.init(frame: frame)
        initLayout()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initLayout()
    }
    
    private func initLayout() {
        desc = UILabel()
        desc.numberOfLines = 0
        desc.lineBreakMode = .byWordWrapping
        checkboxSelectedTextColor = desc.textColor
        checkboxDeselectTextColor = desc.textColor
        addSubview(desc)
        desc.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func useCheckbox(withImageOn: String, off: String) {
        checkbox = UIButton()
        checkbox.setImage(UIImage(named: withImageOn), for: .highlighted)
        checkbox.setImage(UIImage(named: off), for: .normal)
        checkbox.setImage(UIImage(named: withImageOn), for: .selected)
        checkbox.setImage(UIImage(named: off), for: [.selected, .highlighted])
        
        if checkbox.superview != nil {
            checkbox.removeFromSuperview()
        }
        addSubview(checkbox)
        
        checkbox.addTarget(self, action: #selector(tappedCheckbox), for: .touchUpInside)
        checkbox.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func setCheckboxHidden(state: Bool) {
        checkbox.isHidden = state
        
        layoutView()
    }
    
    public func setCheckboxDisable(state: Bool) {
        checkbox.isEnabled = !state
    }
    
    public func setCheckboxChecked(state: Bool) {
        if state != checkbox.isSelected {
            tappedCheckbox()
        }
    }
    
    public func getCheckboxChecked() -> Bool {
        return checkbox.isSelected
    }
    
    @objc func tappedCheckbox() {
        checkbox.isSelected = !checkbox.isSelected
        delegate?.didSelect?(tag: self.tag, isChecked: checkbox.isSelected)
        if checkboxSelectedTextColor != checkboxDeselectTextColor {
            desc.textColor = checkbox.isSelected ? checkboxSelectedTextColor : checkboxDeselectTextColor
        }
    }
    
    public func useAdditionalButton(btn: UIButton) {
        additionalButton = btn

        if additionalButton.superview != nil {
            additionalButton.removeFromSuperview()
        }
        addSubview(additionalButton)
        
        additionalButton.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        additionalButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func tappedButton() {
        delegate?.didTappedAdditionalButton?(tag: self.tag)
    }

    public override func sizeToFit() {
        super.sizeToFit()
        layoutView()
    }

    func layoutView() {
        
        desc.sizeToFit()
        
        var containerHeight = desc.bounds.size.height
        var additionalButtonHeight: CGFloat = 0
        var verticalFormat = ""
        
        var views: [String:UIView] = [:]
        views["desc"] = desc
        
        
        if autoLayoutConstraints.count > 0 {
            NSLayoutConstraint.deactivate(autoLayoutConstraints)
            autoLayoutConstraints.removeAll()
        }
        
        let makeCheckboxConstraint: String = {
            if checkbox != nil && checkbox.isHidden == false {
                views["checkbox"] = checkbox
                containerHeight = max(containerHeight, checkbox.bounds.size.height)
                return "[checkbox]-checkboxSpace-"
            }
            return ""
        }()
        
        let makeAdditionalConstraint: String = {
            if additionalButton != nil {
                views["additionalButton"] = additionalButton
                
                if additionalButton.frame.size == CGSize.zero {
                    verticalFormat = "V:|-containerTop-[additionalButton]-containerBottom-|"
                    return String.init(format: "-additionalButtonSpace-[additionalButton]", additionalButton.frame.size.width)
                } else {
                    additionalButtonHeight = additionalButton.frame.size.height
                    containerHeight = max(containerHeight, additionalButton.frame.size.height)
                    verticalFormat = "V:[additionalButton(additionalButtonHeight)]"
                    return String.init(format: "-additionalButtonSpace-[additionalButton(%f)]", additionalButton.frame.size.width)
                }
            }
            return ""
        }()
        
        let makeDescConstraint: String = {
            if additionalButton != nil, additionalButton.frame.size == CGSize.zero {
                return String.init(format: "(%f)", desc.frame.size.width)
            }
            return ""
        }()
        
        let horizontalFormat = String.init(format: "H:|-containerLeft-%@[desc%@]%@-containerRight-|", makeCheckboxConstraint, makeDescConstraint, makeAdditionalConstraint)
        
        let metrics:[String : Any] = [
            "containerTop": containerInset.top,
            "containerLeft": containerInset.left,
            "containerRight": containerInset.right,
            "containerBottom": containerInset.bottom,
            "checkboxSpace": checkboxSpace,
            "additionalButtonSpace": additionalButtonSpace,
            "containerHeight": containerHeight,
            "additionalButtonHeight": additionalButtonHeight]

        autoLayoutConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-containerTop-[desc]-containerBottom-|", metrics: metrics, views: views)
        autoLayoutConstraints += NSLayoutConstraint.constraints(withVisualFormat: horizontalFormat, options: .alignAllCenterY, metrics: metrics, views: views)
        if verticalFormat.count > 0 {
            autoLayoutConstraints += NSLayoutConstraint.constraints(withVisualFormat: verticalFormat, metrics: metrics, views: views)
        }
        
        
        
        NSLayoutConstraint.activate(autoLayoutConstraints)
        updateConstraints()
    }
    

}

@objc public protocol LabelButtonViewDelegate: class {
    @objc optional func didSelect(tag: Int, isChecked: Bool)
    @objc optional func didTappedAdditionalButton(tag: Int)
}
