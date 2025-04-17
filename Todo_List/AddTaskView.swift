//
//  AddTask.swift
//  Todo_List
//
//  Created by JiHu Park on 2025-04-17.
//

import SwiftUI
import SwiftData

struct AddTaskView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var task: String = ""
    @State private var taskDescription: String = ""
    @State private var dueDate: Date = Date()
    @State private var hasDueDate: Bool = false
    
    var body: some View {
        NavigationStack{
            Form {
                Section(header: Text("")) {
                    TextField("Task", text: $task)
                }
                
                Section(header: Text("")) {
                    TextField("Description", text: $taskDescription)
                }
                
                Section(header: Text("Due Date")) {
                    Toggle("Has Due Date", isOn: $hasDueDate)
                    if hasDueDate {
                        DatePicker("Due Date", selection: $dueDate)
                    }
                }
            }
        }
        .navigationTitle("New Task")
        .toolbar {
            ToolbarItem {
                Button("Cancel") {
                    dismiss()
                }
            }
            ToolbarItem {
                Button("Save") {
                    addTask()
                }
                .disabled(task.isEmpty)
            }
            }
    }
    
    private func addTask() {
        let newItem = Item(
            task: task,
            taskDescription: taskDescription.isEmpty ? nil : taskDescription,
            completed: false,
            dueDate: hasDueDate ? dueDate : nil
        )
        modelContext.insert(newItem)
        dismiss()
    }
}
