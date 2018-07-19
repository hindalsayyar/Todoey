//
//  ViewController.swift
//  Todoey
//
//  Created by imedev4 on 02/11/1439 AH.
//  Copyright © 1439 5W2H. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController{
    
    var toDoItems:Results<Item>?
    let realm = try! Realm()
    var selectedCategory: Category?{ // this is gloable variable 
        didSet{
            loadItem ()
        }
    }
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)



    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
        

    }
    
    //MARK: - tableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { // you have to specify how many rows in this table that way we created the array.
        return toDoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        if let item = toDoItems?[indexPath.row]{
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        }else{
            cell.textLabel?.text = "No Items Add"
        }
        
        return cell
    }
    
    //MARK: - tableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = toDoItems?[ indexPath.row]{
            do{
            try realm.write {
                item.done = !item .done
            }
            }catch{
                print("Error Updating \(error)")
            }
        }
        tableView.reloadData()
  
        //tableView.deselectRow(at: indexPath, animated: true)
        
    }
    //MARK: - Add New Items
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        var createText = UITextField()
        let alert = UIAlertController(title: "Add New Todo list Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "add", style: .default) { (action) in
            
            // when ever the button pressed add item
            if let currentCategory = self.selectedCategory{
                do {
                try self.realm.write {
                    let newItem = Item()
                    newItem.title = createText.text!
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                    }} catch {
                        print("Error Saving \(error)")                }
               
            }
           
 
            self.tableView.reloadData()
        }
        alert.addTextField(configurationHandler: { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            createText = alertTextField
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - model Manipulation Methods

    func loadItem () {
        toDoItems = (selectedCategory?.items.sorted(byKeyPath: "dateCreated", ascending: true))!
        
 
        tableView.reloadData()
    }
//
    

}
//MARK: - search bar methods
extension ToDoListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        toDoItems = toDoItems?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        tableView.reloadData()

    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItem()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }

    }
}
