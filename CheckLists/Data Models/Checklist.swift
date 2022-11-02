//
//  Checklist.swift
//  CheckLists
//
//  Created by Dzhami Rakhmetov on 11/10/22.
//

import UIKit

class Checklist: NSObject, Codable {
var name = ""
    //new empty array that can hold ChecklistItem objects and assigns it to the items property
var items = [ChecklistItem]()
    
    init (name : String) {
        self.name = name
        super.init()
    }
    
}
