//
//  ToDoTableViewController.swift
//  Xhale
//
//  Created by Muryam Hasan on 7/13/20.
//  Copyright © 2020 Muryam Hasan. All rights reserved.
//

import UIKit

class ToDoTableViewController: UITableViewController {
    
    func createToDos() -> [ToDo] {
        let swift = ToDo ()
        swift.name = "Learn Swift"
        swift.important = true
        
        let dog = ToDo ()
        dog.name = "Walk the Dog"
        
        return [swift, dog]
    }
    
    func getToDos() {
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                   if let coreDataToDos = try? context.fetch(ToDoCD.fetchRequest()) as? [ToDoCD] {
                    if let theToDos = coreDataToDos {
                           toDos = theToDos
                           tableView.reloadData()
                           
                   }
                   }
                   }
               }
    
    var toDos : [ToDoCD] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getToDos()
       //toDos = createToDos()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
      
        let toDo = toDos [indexPath.row]
        
        if let name = toDo.name {
        if toDo.important {
            cell.textLabel?.text = "❗️" + toDo.name
        } else {
            cell.textLabel?.text = toDo.name
        }
        }
        
        return cell

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
               let toDo = toDos[indexPath.row]
               performSegue(withIdentifier: "moveToComplete", sender: toDo)
           }
    
    override func viewWillAppear(_ animated: Bool) {
        getToDos()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addVC = segue.destination as? AddToDoViewController {
            addVC.previousVC = self
        }
        
        if let completeVC = segue.destination as? CompleteToDoViewController {
            if let toDo = sender as? ToDoCD {
                completeVC.selectedToDo = toDo
                completeVC.previousVC = self
            }
        }

    }

}
