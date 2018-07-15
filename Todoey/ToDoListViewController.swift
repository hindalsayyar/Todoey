//
//  ViewController.swift
//  Todoey
//
//  Created by imedev4 on 02/11/1439 AH.
//  Copyright © 1439 5W2H. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = ["egg1","egg2","egg3",]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
   //MARK - tableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // you have to specify how many rows in this table that way we created the array.
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    //MARK - tableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark){
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        var createText = UITextField()
        let alert = UIAlertController(title: "Add New Todo list Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add", style: .default) { (action) in
            // when ever the button pressed add item
            self.itemArray.append(createText.text!)
            print(self.itemArray)
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

