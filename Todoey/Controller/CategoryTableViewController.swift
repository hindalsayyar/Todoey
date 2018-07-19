//
//  CategoryTableViewController.swift
//  Todoey
//
//  Created by imedev4 on 04/11/1439 AH.
//  Copyright © 1439 5W2H. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryTableViewController: UITableViewController {
    let realm = try! Realm()
    
    var categoryArray : Results<Category>?
  



    override func viewDidLoad() {
        super.viewDidLoad()

        //self.navigationItem.rightBarButtonItem = self.editButtonItem
        loadCategory()
    }
    
    //MARK: TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if  let indexPath = tableView.indexPathForSelectedRow { // if the index path not nil then
            destinationVC.selectedCategory = categoryArray?[indexPath.row]
        }
    }


 
    
    //MARK: TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categoryArray?[indexPath.row].name ?? "No Categories add"
        return cell
    }
    //MARK: Add New Category
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
            let alert = UIAlertController(title: "Add Category Name:", message: "", preferredStyle: .alert)
            var textField = UITextField()
            let actionButtonAlert = UIAlertAction(title: "Add", style: .default) { (actionButtonAlert) in
                var newCategory = Category()
                newCategory.name = textField.text!
                print(newCategory.name)
                self.save(category: newCategory)
            }
            alert.addTextField { (alertTextField) in
                alertTextField.placeholder = "Create New Category"
                textField = alertTextField
            }
            alert.addAction(actionButtonAlert)
            present(alert, animated: true, completion: nil)
            
    }
    
    //MARK: Data Manipulation Methods
    
    func save(category:Category){
        do{
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error when saving Data: \(error)")
        }
        tableView.reloadData()

    }
    
    func loadCategory()
  {
    
    categoryArray = realm.objects(Category.self)
 
    }
    
    


 

}
