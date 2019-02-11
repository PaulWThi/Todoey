//
//  ViewController.swift
//  Todoey
//
//  Created by paul thi on 2/4/19.
//  Copyright © 2019 Ambam. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {

    // Can add through Main.storyboard
//    @IBOutlet weak var searchBar: UISearchBar!
    
    var items: Results<Item>?
    let realm = try!  Realm()
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        searchBar.delegate = self
    }
    
    // MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = items?[indexPath.row] {
            cell.textLabel?.text = item.title
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        // Uses Realm
        if let item = items?[indexPath.row] {
            do {
                try realm.write {
                    // Deletes from realm
//                    realm.delete(item)
                    item.done = !item.done
                }
            } catch {
                print("error saving item \(error)")
            }
        }
        
        tableView.reloadData()
        
        // Deletes items
//        context.delete(itemArray[indexPath.row])
//        itemArray.remove(at: indexPath.row)
        
        // Updates items. Both perform same thing.
//        itemArray[indexPath.row].title = "completed"
//        itemArray[indexPath.row].setValue("completed", forKey: "Title")
        
        
        // Flips itemArray's .done property from true to false and false to true
//        items[indexPath.row].done = !items[indexPath.row].done
//
//        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        let item = Item()
                        item.title = textField.text!
//                        item.dateCreated = Date()
                        currentCategory.items.append(item)
                    }
                } catch {
                    print("error saving item \(error)")
                }
            }
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
//    func saveItems() {
//
//        do {
//            try context.save()
//        } catch {
//            print("error saving context \(error)")
//        }
//
//        self.tableView.reloadData()
//
//    }
    
    func loadItems() {

       items = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)

        tableView.reloadData()

    }
    
}

// MARK: - Search Bar Methods
extension ToDoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        items = items?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }
}

