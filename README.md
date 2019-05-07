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
ItemLabelData(key: "-", 
              val: "key label and value label",
              keyAttributes: [NSAttributedString.Key.foregroundColor: UIColor.yellow,
                              NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)],
                                         valAttributes: nil)
```






