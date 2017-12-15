//
//  TaskDetailsViewController.swift
//  MyToDo
//
//  Created by Dante  Lacey-Thompson on 12/14/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import RealmSwift

class TaskDetailsViewController: FormViewController {
    
    var addingTask: Bool = true
    var editingTask: Task!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Details View Loaded")
        NotificationCenter.default.addObserver(self, selector: #selector(recievedAddNotification(notification:)), name: NSNotification.Name("ObjectAdded"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(recievedUpdatedNotification(notification:)), name: NSNotification.Name("ObjectUpdated"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (addingTask) {
            self.navigationItem.title = "Add Task"
//            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addTask))
            let addButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(addTask))
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTask))
            self.navigationItem.rightBarButtonItems = [addButton, cancelButton]
            print("Adding Task")
            setUpAddView()
        } else if !(addingTask) {
            self.navigationItem.title = "Edit Task"
            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelTask))
            let updateButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editTask))
            self.navigationItem.rightBarButtonItems = [updateButton, cancelButton]
            setUpEditView()
            print("Editing Task")
        }
    }
    
    func setUpAddView(){
        var rules = RuleSet<String>()
        rules.add(rule: RuleRequired())
        form +++ Section("TaskName")
            <<< TextRow(){
                row in
                row.title = "Note"
                row.tag = "noteRow"
                row.placeholder = "e.g Go to store"
                row.add(ruleSet: rules)
        }
            +++ Section("Due Date")
            <<< DateRow(){
                row in
                row.title = "Due Date"
                row.tag = "dateRow"
                row.minimumDate = Date()
//                row.value = Date()
//                row.add(ruleSet: rules)
        }
            <<< SegmentedRow<String>(){
                row in
                row.title = "Priority"
                row.options = [Task.Priority.low.rawValue, Task.Priority.medium.rawValue, Task.Priority.high.rawValue]
                row.tag = "priorityRow"
                row.add(ruleSet: rules)
        }
    }
    
    func setUpEditView(){
        var rules = RuleSet<String>()
        rules.add(rule: RuleRequired())
        form +++ Section("TaskName")
            <<< TextRow(){
                row in
                row.title = "Note"
                row.tag = "noteRow"
                row.value = editingTask.note
                row.add(ruleSet: rules)
            }
            +++ Section("Due Date")
            <<< DateRow(){
                row in
                row.title = "Due Date"
                row.tag = "dateRow"
                row.minimumDate = Date()
                row.value = editingTask.dueDate
                //                row.value = Date()
                //                row.add(ruleSet: rules)
            }
            <<< SegmentedRow<String>(){
                row in
                row.title = "Priority"
                row.options = [Task.Priority.low.rawValue, Task.Priority.medium.rawValue, Task.Priority.high.rawValue]
                row.tag = "priorityRow"
                row.value = editingTask.priority.rawValue
                row.add(ruleSet: rules)
        }

    }
    
    func cancelTask(){
        print("Cancel Button pressed")
        self.navigationController?.popViewController(animated: true)
    }
    
    func addTask(){
        print("Save Button Tapped")
        if form.validate().isEmpty { //no validation errors
            print("No validation errors")
            let formValues = form.values()
//            print(formValues)
            if let priorityVal = formValues["priorityRow"], let noteVal = formValues["noteRow"], let dateVal = formValues["dateRow"] {
                print(priorityVal ?? Task.Priority.low.rawValue, noteVal ?? "Random Task because Note is nill", dateVal ?? Date())
                let newTask = Task()
                newTask.note = noteVal as! String
                newTask.prioritylevel = priorityVal as! String
                newTask.dueDate = dateVal as? Date
                do {
                   let realm = try Realm()
                    do {
                        try realm.write {
                            realm.add(newTask)
                            NotificationCenter.default.post(name: NSNotification.Name("ObjectAdded"), object: nil)
                        }
                    } catch let writeError as NSError {
                        print("writeError: \(writeError)")
                    }
                } catch let error as NSError {
                    print("Error trying Realm: \(error)")
                }
            }
        } else {
            print("Validation Errors can't proceed")
        }
    }
    
    func editTask(){
        print("EditButton Tapped")
        if form.validate().isEmpty { //No validation Errors
            print("Validation passed")
            let formValues = form.values()
            if let priorityVal = formValues["priorityRow"], let noteVal = formValues["noteRow"], let dateVal = formValues["dateRow"] {
                do {
                    let realm = try Realm()
                    let tasks = realm.objects(Task.self).filter("note = %@", editingTask.note)
                    do {
                        if let task = tasks.first{
                            try realm.write {
                                task.note = noteVal as! String
                                task.prioritylevel = priorityVal as! String
                                task.dueDate = dateVal as? Date
                                NotificationCenter.default.post(name: NSNotification.Name("ObjectUpdated"), object: nil)
                            }
                        }
                    } catch let writeError as NSError {
                        print(writeError)
                    }

                } catch let error as NSError {
                    print(error)
                }
            }
        } else {
            print("Validation failed")
        }
    }

    func deleteTask(){
        print("Deleting Object")
        do {
            let realm = try Realm()
            let tasks = realm.objects(Task.self).filter("note = %@", editingTask.note)
            do {
                if let task = tasks.first{
                    try realm.write {
                        realm.delete(task)
                    }
                }
            } catch let writeError as NSError {
                print(writeError)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func recievedAddNotification(notification: Notification){
        print("recieved add notification")
        performSegue(withIdentifier: "addToMain", sender: self)
    }
    
    func recievedUpdatedNotification(notification: Notification){
        print("Recieved updated Notification")
        performSegue(withIdentifier: "addToMain", sender: self)
    }
}
