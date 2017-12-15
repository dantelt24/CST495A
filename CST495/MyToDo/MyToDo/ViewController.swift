//
//  ViewController.swift
//  MyToDo
//
//  Created by Dante  Lacey-Thompson on 12/13/17.
//  Copyright © 2017 Dante  Lacey-Thompson. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var taskList = [Task]()
    var filteredTaskList = [Task]()
    var inSearchMode=false
    
    @IBOutlet weak var taskTableView: UITableView!
    @IBOutlet weak var taskSearchBar: UISearchBar!
    
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fetchDBResults()
        taskTableView.delegate = self
        taskTableView.dataSource = self
        taskSearchBar.delegate = self
        self.navigationItem.title = "TODO List"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(infoSelected)) 
//        placeHolderTask()
//        fetchDBResults()
//        removeDBRecords()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: SearchBar Functions
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if taskSearchBar.text == nil || taskSearchBar.text == "" {
            inSearchMode = false
            view.endEditing(true)
        } else {
            inSearchMode = true
            let search = taskSearchBar.text?.lowercased()
            filteredTaskList = taskList.filter({$0.note.range(of: search!) != nil})
        }
        taskTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    
    //MARK: Tableview functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? filteredTaskList.count : taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = taskTableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as? taskCell{
            cell.configCell(TM: inSearchMode ? filteredTaskList[indexPath.row] : taskList[indexPath.row])
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var searchedTask: Task!
        searchedTask = inSearchMode ? filteredTaskList[indexPath.row] : taskList[indexPath.row]
        performSegue(withIdentifier: "editSegue", sender: searchedTask)
    }

    //MARK: ViewController functions
    func placeHolderTask(){
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.short
        let placeHolderTask = Task()
        placeHolderTask.note = "PlaceHolder Task"
        placeHolderTask.prioritylevel = "low"
        placeHolderTask.dueDate = Date()
        print(dateFormatter.string(from: placeHolderTask.dueDate!))
        taskList.append(placeHolderTask)
        do {
           let realm = try Realm()
            do {
                try realm.write {
                    realm.add(placeHolderTask)
                }
            } catch let writeError as NSError {
                print(writeError)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func fetchDBResults(){
        do {
            let realm = try Realm()
            taskList = realm.objects(Task.self).toArray(ofType: Task.self)
            if taskList.isEmpty {
                print("No results from the db")
                placeHolderTask()
            } else {
                print("Tasks within db: \(taskList.count)")
//                for task in taskList {
//                    print(task.note)
//                }
            }
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    func removeDBRecords(){
        do {
            let realm = try Realm()
            do {
                try realm.write {
                    realm.deleteAll()
                }
            } catch let deleteAllError as NSError {
                print(deleteAllError)
            }
        } catch let error as NSError {
            print(error)
        }
    }
    
    func addButtonTapped(){
        print("Add Button Tapped")
        performSegue(withIdentifier: "addSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addSegue"{
            if let taskDetailsVC = segue.destination as? TaskDetailsViewController{
                taskDetailsVC.addingTask = true
            }
        }
        else if segue.identifier == "editSegue"{
            if let taskDetailsVC = segue.destination as? TaskDetailsViewController{
                taskDetailsVC.addingTask = false
                if let editTask = sender as? Task{
                    taskDetailsVC.editingTask = editTask
                }
            }
        }
    }
    
    func infoSelected(){
        performSegue(withIdentifier: "infoSegue", sender: self)
    }

}

extension Results{
    func toArray<T>(ofType: T.Type) -> [T] {
        return flatMap { $0 as? T }
    }
}
