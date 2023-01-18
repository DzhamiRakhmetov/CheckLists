import UIKit

class Checklist: NSObject, Codable {
    var name = ""
    //new empty array that can hold ChecklistItem objects and assigns it to the items property
    var items = [ChecklistItem]()
    var iconName = "No Icon"
    
    init (name : String, iconName : String = "No Icon") {
        self.name = name
        self.iconName = iconName
        super.init()
    }
    
    // count how many ChecklistItem objects are still not checked
    
    func countUncheckedItems() -> Int{
        return items.reduce(0) { cnt, item in cnt + (item.checked ? 0 : 1 )}
    }
}
//    func countUncheckedItems() -> Int {
//        var count = 0
//        for item in items where !item.checked {
//             count += 1
//        }
//        return count
//    }

