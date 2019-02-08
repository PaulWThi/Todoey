//
//  ViewController.swift
//  Todoey
//
//  Created by paul thi on 2/4/19.
//  Copyright © 2019 Ambam. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    let itemArray = ["Find Mike", "Buy Eggs", "Destroy TV"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //MARK - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        cell.textLabel?.text = itemArray[indexPath.row]
        
        return cell
    }
    
    //MARK - Tableview Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        //let checkmark = hasCheckmark(accessoryType: (tableView.cellForRow(at: indexPath)?.accessoryType)!)
        //tableView.cellForRow(at: indexPath)?.accessoryType = checkmark
        
        let check : (UITableViewCell) -> () = {
            if $0.accessoryType == .checkmark {
                $0.accessoryType = .none
            } else {
                $0.accessoryType = .checkmark
            }
        }
        check(tableView.cellForRow(at: indexPath)!)
        
        
        
        
//        tableView.cellForRow(at: indexPath)?.accessoryType : UITableViewCell.AccessoryType = {
        
//        if checkmark == .checkmark {
//
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func checkForCheckmark(doesItHaveCheckMark cell: UITableViewCell) -> () {
        if cell.accessoryType == .checkmark {
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .checkmark
        }
    }
    
}

