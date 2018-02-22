//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Govardhan on 2/21/18.
//  Copyright © 2018 Govardhan. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    var categoryArray = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       loadCategory()
    }
    
    // MARK:- Tableview Datasource methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellItem", for: indexPath)
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        cell.accessoryType = .detailButton
        
        return cell
    }
    
    // MARK:- Tableview Delegate methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListTableViewController
        let indexPath = tableView.indexPathForSelectedRow
        destinationVC.selectedCategory = categoryArray[(indexPath?.row)!]
    }
    // add Button pressed
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text!
            
            self.categoryArray.append(newCategory)
            self.saveCategory()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Add a New Category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK:- Data Manipulation methods
    
    func saveCategory() {
        do {
            try context.save()
        } catch {
            print("Error saving context,\(error)")
        }
        self.tableView.reloadData()
        
    }
    
    func loadCategory() {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do{
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching Data from context, \(error)")
        }
        tableView.reloadData()
        
    }
}
