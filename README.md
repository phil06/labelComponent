# labelComponent
label framework

```swift
import LabelComponent
```

## inner margin
```swift
var label: ExtendedUILabel!
label.inset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
```

## border
```swift
label.layerBorderColor = UIColor.black //default
label.layerBorderWidth: CGFloat = 0
```

## estimate string rect size
```swift
let font = UIFont.systemFont(ofSize: 13)
//estimate by fixed width
let fontSize = font.sizeOf(string: "가나다라마바사아자차123오호호힝..m,.mㅁㄴ", byWidth: 40)
//estimate with font size(height)
let fontSize2 = font.sizeOf(string: "가나다라마바사아자차123오호호힝..m,.mㅁㄴ")
```

## label list collection
```swift
var labelComponent OrderedItemLabelView!

var data: [ItemLabelData] = []

// spacing : vertical item space
// inset : default item inset
// outterInset : collection inset
// defaultAttributes : default label attributes(key/value)
labelComponent.setLayout(data: self.data, 
                         spacing: 5, 
                         inset: UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7), 
                         outterInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
                         defaultAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),
                                             NSAttributedString.Key.foregroundColor: UIColor.black])
```

### ItemLabelData
#### value label only
```swift
ItemLabelData(val: "value label only")
```
#### key label and value label
```swift
ItemLabelData(key: "-", val: "key label and value label")
```

#### key label and value label with individual attributes
```swift
ItemLabelData(key: "-", 
              val: "key label and value label with individual attributes",
              keyAttributes: [NSAttributedString.Key.foregroundColor: UIColor.yellow,
                              NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)],
                                         valAttributes: nil)
```

## label table collection
```swift
var table: TableLayoutView!

// header model 데이터 생성 (없어도 됨)
var headers: [TableItemData] = []
headers.append(TableItemData(desc: "취소일", attr: nil, bgColor: UIColor.gray))
headers.append(TableItemData(desc: "취소 수수료", attr: nil, bgColor: UIColor.gray))
        
// content model 데이터 생성 (필수)
var contents: [TableItemRowData] = []
contents.append(TableItemRowData(items: [TableItemData(desc: "1행 1열", attr: nil, bgColor: nil),
                                                 TableItemData(desc: "1행 2열", attr: nil, bgColor: nil)] ))
contents.append(TableItemRowData(items: [TableItemData(desc: "2행 1열", attr: nil, bgColor: nil),
                                                 TableItemData(desc: "2행 2열", attr: nil, bgColor: nil)] ))
contents.append(TableItemRowData(items: [TableItemData(desc: "3행 1열", attr: nil, bgColor: nil),
                                                 TableItemData(desc: "3행 2열", attr: nil, bgColor: nil)] ))
contents.append(TableItemRowData(items: [TableItemData(desc: "4행 1열", attr: nil, bgColor: nil),
                                                 TableItemData(desc: "4행 2열", attr: nil, bgColor: nil)] ))
contents.append(TableItemRowData(items: [TableItemData(desc: "5행 1열", attr: nil, bgColor: nil),
                                                 TableItemData(desc: "5행 2열", attr: nil, bgColor: nil)] ))
        
var dataSource: TableItemLabelData
//data source 설정
dataSource = TableItemLabelData(headers: headers, data: contents)
//table 전체 여백
dataSource.cellLayoutMargin = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//컬럼 너비 비율 [n1,n2,n3...]
dataSource.widthRatio = [55,45]

table.bindDataSource(data: dataSource)

//컬럼간 여백
table.horizontalSpacing = 10

//행 하단에 border 설정할때
table.rowUnderlineColor = UIColor.red
table.rowUnderlieWidth = 1.0

table.sizeToFit()
```

## checkbox + label + additional button label



