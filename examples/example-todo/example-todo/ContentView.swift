//
//  ContentView.swift
//  example-todo
//

import SwiftUI

struct ContentView: View {
    @State private var newTask = ""
    @State private var tasks = ["Task 1", "Task 2", "Task 3"]

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Add task", text: $newTask)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Add") {
                      if context.feature("FEATURE_TITLE_TO_UPPERCASE").enabled {
                        tasks.append(newTask.uppercased())
                      } else {
                        tasks.append(newTask)
                      }
                        
                        newTask = ""
                    }
                }
                List {
                    ForEach(tasks, id: \.self) { task in
                        Text(task)
                    }
                            .onDelete(perform: deleteTask)
                }
            }
                    .navigationBarTitle("Todo List")
        }
    }

    func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

