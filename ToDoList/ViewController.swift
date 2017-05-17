//
//  ViewController.swift
//  ToDoList
//
//  Created by Bherly Novrandy on 5/1/17.
//  Copyright © 2017 Bherly Novrandy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var buttonSave: UIButton!
    
    var arrayData: [String] = ["ToDoList 1", "ToDoList 2"]
    var rowToSave: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        myTableView.register(nib, forCellReuseIdentifier: "CustomTableViewCell")
        self.buttonSave.addTarget(self, action: #selector(ViewController.doSave), for: .touchUpInside)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell {
            let data = arrayData[indexPath.row]
            cell.myCustomLabel.text = data
            
            cell.customButton.tag = indexPath.row
            cell.deleteButton.tag = indexPath.row
            
            cell.customButton.addTarget(self, action: #selector(ViewController.editTodo), for: .touchUpInside)
            cell.deleteButton.addTarget(self, action: #selector(ViewController.deleteTodo), for: .touchUpInside)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func editTodo(sender: UIButton) {
        let rowNumber = sender.tag
        self.rowToSave = rowNumber
        let data = arrayData[rowNumber]
        
        self.textField.text = data
        self.buttonSave.setTitle("Save", for: .normal)
    }
    
    func deleteTodo(sender: UIButton) {
        let rowNumber = sender.tag
        arrayData.remove(at: rowNumber)
        self.myTableView.reloadData()
    }
    
    func resetForm() {
        self.buttonSave.setTitle("Submit", for: .normal)
        self.textField.text = ""
    }
    
    func doSave() {
        if let title = self.buttonSave.title(for: .normal) {
            if title == "Save" {
                if let name = self.textField.text {
                    self.arrayData[self.rowToSave] = name
                }
            }
            else if title == "Submit" {
                if let name = self.textField.text {
                    self.arrayData.append(name)
                }
            }
            resetForm()
            self.myTableView.reloadData()
        }
    }
    
}
