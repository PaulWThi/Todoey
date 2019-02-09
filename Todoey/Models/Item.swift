//
//  Item.swift
//  Todoey
//
//  Created by paul thi on 2/8/19.
//  Copyright © 2019 Ambam. All rights reserved.
//

import Foundation

class Item : Codable {

    var title : String = ""
    var done : Bool = false
    
    init(titleInput : String, doneInput : Bool) {
        self.title = titleInput
        self.done = doneInput
    }
    
}
