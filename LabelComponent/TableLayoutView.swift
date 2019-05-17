//
//  TableLayoutView.swift
//  LabelComponent
//
//  Created by NHNEnt on 08/05/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import UIKit

public class TableLayoutView: UIView {

    var stackViewV: UIStackView!
    public var horizontalSpacing: CGFloat = 0
    public var rowUnderlineColor: UIColor = UIColor.clear
    public var rowUnderlieWidth: CGFloat = 0

    public override init(frame: CGRect) {
        super.init(frame: frame)

        initLayout()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        initLayout()
    }

    private func initLayout() {
        stackViewV = UIStackView()
        stackViewV.axis = .vertical
        stackViewV.alignment = .fill
        stackViewV.spacing = 0
        addSubview(stackViewV)
        stackViewV.translatesAutoresizingMaskIntoConstraints = false

        let stackView_H = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[stackViewV]-0-|",
                                                         metrics: nil,
                                                         views: ["stackViewV": stackViewV])
        let stackView_V = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[stackViewV]-0-|",
                                                         metrics: nil,
                                                         views: ["stackViewV": stackViewV])

        NSLayoutConstraint.activate(stackView_H + stackView_V)
    }

    public func bindDataSource(data: TableItemLabelData) {
        
        if let headers = data.headers, headers.count > 0 {

            let stackViewH = UIStackView()
            stackViewH.axis = .horizontal
            stackViewH.alignment = .fill
            stackViewH.distribution = .fillProportionally
            stackViewH.spacing = horizontalSpacing
            
            for item in headers.enumerated() {
                let label = LabelView()
                label.setLayout(inset: data.cellLayoutMargin,
                                attr: NSMutableAttributedString(string: item.element.desc, attributes: item.element.attributes ?? data.defaultAttr),
                                bgColor: item.element.backgroundColor)
                label.activeLayerBorder(color: data.borderColor, width: data.borderWidth)
                
                label.ratio = data.widthRatio[item.offset]
                stackViewH.addArrangedSubview(label)
            }

            self.stackViewV.addArrangedSubview(stackViewH)
        }
        
        for row in data.contentData {
            
            let stackViewH = UIStackView()
            stackViewH.axis = .horizontal
            stackViewH.alignment = .fill
            stackViewH.distribution = .fillProportionally
            stackViewH.spacing = horizontalSpacing
            
            for item in row.items.enumerated() {
                let label = LabelView()
                label.setLayout(inset: data.cellLayoutMargin,
                                attr: NSMutableAttributedString(string: item.element.desc, attributes: item.element.attributes ?? data.defaultAttr),
                                bgColor: item.element.backgroundColor)
                label.activeLayerBorder(color: data.borderColor, width: data.borderWidth)
                
                label.ratio = data.widthRatio[item.offset]
                
                stackViewH.addArrangedSubview(label)
            }
            
            if rowUnderlieWidth > 0 {
                stackViewH.addUnderline(color: rowUnderlineColor, thickness: rowUnderlieWidth)
            }
            
            self.stackViewV.addArrangedSubview(stackViewH)

        }
        
    }
    
}

extension UIView {
    func addUnderline(color: UIColor, thickness: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        addSubview(border)
        border.translatesAutoresizingMaskIntoConstraints = false
        
        border.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -thickness).isActive = true
        border.heightAnchor.constraint(equalToConstant: thickness).isActive = true
        border.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        border.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
