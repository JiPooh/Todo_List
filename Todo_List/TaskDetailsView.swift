//
//  TaskDetails.swift
//  Todo_List
//
//  Created by JiHu Park on 2025-04-17.
//

import SwiftUI
import SwiftData

struct TaskDetailsView: View {
    @Bindable var item: Item
    
    var body: some View {
        Form {
            Section("Task") {
                TextField("", text: ($item.task))
                TextEditor(text: Binding($item.taskDescription, replacingNilWith: ""))
                if let dueDate = item.dueDate {
                        DatePicker("", selection: Binding($item.dueDate, replacingNilWith: Date()), displayedComponents: .date)
                } else {
                    Button("Add Due Date") {
                        item.dueDate = Date()
                    }
                }
                Toggle("Completed", isOn: $item.completed)
            }
            Section {
                Button("Delete") {
                    deleteTast()
                }
            }
        }
        .navigationTitle("Task Details")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
    
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    private func deleteTast() {
        modelContext.delete(item)
        dismiss()
    }
}

// helper extension to give custom initializer for binding that replaces nil with default
extension Binding {
    init(_ source: Binding<Value?>, replacingNilWith defaultValue: Value) {
        self.init(
            get: { source.wrappedValue ?? defaultValue },
            set: { newValue in source.wrappedValue = newValue }
        )
    }
}

