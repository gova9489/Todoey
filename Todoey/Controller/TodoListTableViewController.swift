//
//  TodoListTableViewController.swift
//  Todoey
//
//  Created by Govardhan on 2/8/18.
//  Copyright © 2018 Govardhan. All rights reserved.
//

import UIKit

class TodoListTableViewController: UITableViewController {

    var itemAray = [Item]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let newItem = Item()
        newItem.title = "Batman Begins in Gotham"
        itemAray.append(newItem)
        
        let newItem1 = Item()
        newItem1.title = "Batman meets Joker"
        itemAray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Batman and Joker become BFF"
        itemAray.append(newItem2)
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {

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
        
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "Todocell")
  
        let cell = tableView.dequeueReusableCell(withIdentifier: "Todocell", for: indexPath)

        // Configure the cell...
        let item = itemAray[indexPath.row]
        
        
        cell.textLabel?.text = item.title
        // Ternary operator ==>
        // value = condition ? value of True : value fo False
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemAray[indexPath.row].done = !itemAray[indexPath.row].done
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // Mark: - Add items to list
    @IBAction func addButtonPressed(_ sender: Any) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemAray.append(newItem)
            
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
