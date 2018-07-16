//
//  ViewController.swift
//  Todoey
//
//  Created by imedev4 on 02/11/1439 AH.
//  Copyright © 1439 5W2H. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    
    var defults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "egg1"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "egg2"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "egg3"
        itemArray.append(newItem3)
        
        
        if let items = defults.array(forKey: "ToDolist") as? [Item]{
            itemArray = items
        }
//        if let items = defults.array(forKey: "ToDolist") as? [String]{
//            let newItem = Item()
//            newItem.title = "egg1"
//            itemArray.append(newItem)
//
//                        itemArray = items
        
 //       }
    }
    
   //MARK - tableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // you have to specify how many rows in this table that way we created the array.
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.Done ? .checkmark : .none
        
        return cell
    }
    
    //MARK - tableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].Done = !itemArray[indexPath.row].Done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        var createText = UITextField()
        let alert = UIAlertController(title: "Add New Todo list Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add", style: .default) { (action) in
            // when ever the button pressed add item
            let newItem = Item()
            newItem.title = createText.text!
            
            self.itemArray.append(newItem)
            print(self.itemArray)
            self.defults.set(self.itemArray, forKey: "ToDolist")
            self.tableView.reloadData()
        }
        alert.addTextField(configurationHandler: { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            createText = alertTextField
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    

}

