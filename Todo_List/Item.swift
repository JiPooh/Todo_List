//
//  Item.swift
//  Todo_List
//
//  Created by JiHu Park on 2025-04-17.
//

import Foundation
import SwiftData

@Model
final class Item {
    var task: String
    var taskDescription: String?
    var completed: Bool
    var dueDate: Date?
    
    init(task: String, taskDescription: String? = nil, completed: Bool = false, dueDate: Date? = nil) {
        self.task = task
        self.taskDescription = taskDescription
        self.completed = completed
        self.dueDate = dueDate
    }
}
