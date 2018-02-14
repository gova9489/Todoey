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
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(dataFilePath!)
        loadItems()
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
        saveItems()
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
            self.saveItems()
        }
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    //Mark :- Model manipulation methods
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemAray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding Item Array, \(error)")
        }
        self.tableView.reloadData()
        
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
        let decoder = PropertyListDecoder()
        do {
            itemAray = try decoder.decode([Item].self, from: data)
        } catch {
            print("Error in decoding, \(error)")
        }
        }
    
    }
    

}
