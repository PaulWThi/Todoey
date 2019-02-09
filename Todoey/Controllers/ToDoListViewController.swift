//
//  ViewController.swift
//  Todoey
//
//  Created by paul thi on 2/4/19.
//  Copyright © 2019 Ambam. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = [Item]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
        
//        let item = Item(titleInput: "Find Mike", doneInput: false)
//        itemArray.append(item)
//
//        let item2 = Item(titleInput: "Find Zoe", doneInput: false)
//        itemArray.append(item2)
//
//        let item3 = Item(titleInput: "Find Tom", doneInput: false)
//        itemArray.append(item3)

//        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
//            itemArray = items
//        }
        
        loadItems()
        
    }
    
    // MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    // MARK: - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        let isChecked = itemArray[indexPath.row].done ? true : false
        
        // Flips itemArray's .done property from true to false and false to true
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        
//        let check : (UITableViewCell) -> () = {
//            if $0.accessoryType == .checkmark {
//                $0.accessoryType = .none
//            } else {
//                $0.accessoryType = .checkmark
//            }
//        }
//        check(tableView.cellForRow(at: indexPath)!)
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    // MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoes Item", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in

            let item = Item(titleInput: textField.text!, doneInput: false)

            self.itemArray.append(item)
            
            self.saveItems()
            
//            self.defaults.set(self.itemArray, forKey: "TodoListArray")

            self.tableView.reloadData()
        }
        
        alert.addTextField { (alerttextField) in
            alerttextField.placeholder = "Create new item"
            textField = alerttextField
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - Model Manipulation Methods
    func saveItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("error encoding item array, \(error)")
        }
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                itemArray = try decoder.decode([Item].self, from: data)
            } catch {
                print("error dencoding item array, \(error)")
            }
        }
    }
    
    
}

