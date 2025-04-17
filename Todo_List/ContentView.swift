//
//  ContentView.swift
//  Todo_List
//
//  Created by JiHu Park on 2025-04-17.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    @State private var showingAddTask = false

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        TaskDetailsView(item: item)
                    } label: {
                        HStack {
                            Text(item.task)
                            Spacer()
                            Text(item.completed ? "Completed" : "Not Completed")
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: {
                        showingAddTask.toggle()
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        }
        detail: {
            Text("Select an item")
        }
        .sheet(isPresented: $showingAddTask) {
            AddTaskView()
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(task: "New Task")
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
