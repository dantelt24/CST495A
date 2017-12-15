//
//  taskModel.swift
//  MyToDo
//
//  Created by Dante  Lacey-Thompson on 12/13/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import Foundation
import RealmSwift

class Task: Object {
    dynamic var note = ""
    dynamic var prioritylevel = ""
    dynamic var dueDate: Date? = nil
    
}

//case properties
extension Task{
    enum Priority: String {
        case low
        case medium
        case high
    }
}


//computed variables
extension Task{
    var priority: Priority {
        get {
            return Priority(rawValue: self.prioritylevel)!
        }
        set {
            self.prioritylevel = newValue.rawValue
        }
    }
}
