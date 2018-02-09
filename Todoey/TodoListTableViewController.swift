//
//  TodoListTableViewController.swift
//  Todoey
//
//  Created by Govardhan on 2/8/18.
//  Copyright © 2018 Govardhan. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController {

    var itemAray = ["Work on Basics", "Work on resume", "Work on CoreData"]
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
            
            itemAray = items
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemAray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Todocell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = itemAray[indexPath.row]

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
          
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // Mark: - Add items to list
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            self.itemAray.append(textField.text!)
            
            self.defaults.set(self.itemAray, forKey: "ToDoListArray")
            
            self.tableView.reloadData()
        }
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    

}
