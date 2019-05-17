//
//  TableItemLabelData.swift
//  LabelComponent
//
//  Created by NHNEnt on 08/05/2019.
//  Copyright © 2019 saera. All rights reserved.
//

import Foundation

public class TableItemLabelData: NSObject {
    var headers: [TableItemData]?
    
    var contentData: [TableItemRowData]
    
    public var defaultAttr: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 11),
                                                      .foregroundColor: UIColor.black]
    public var borderColor: UIColor = UIColor.clear
    public var borderWidth: CGFloat = 0
    public var cellLayoutMargin: UIEdgeInsets = UIEdgeInsets.zero
    public var widthRatio:[CGFloat] = []
    
    public init(headers: [TableItemData]? = [],
                data: [TableItemRowData]) {
        self.headers = headers
        self.contentData = data
    }
}

public class TableItemRowData: NSObject {
    var items: [TableItemData]
    
    public init(items: [TableItemData]) {
        self.items = items
    }
}


public class TableItemData: NSObject {
    var desc: String
    var attributes: [NSAttributedString.Key: Any]?
    var backgroundColor: UIColor
    
    public init(desc: String, attr: [NSAttributedString.Key: Any]?, bgColor: UIColor?) {
        self.desc = desc
        self.attributes = attr
        self.backgroundColor = bgColor ?? UIColor.clear
    }
}
