//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Phil on 11/7/17.
//  Copyright © 2017 phlfvry. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load sample data
        loadSampleMeals()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Sections are groups of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // The number of rows in the section should be equal to the size of the array
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "MealTableViewCell"
        
        // dequeueReuseableCell requests a reusable cell from the table view instead of creating a new one (if possible)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell")
        }

        // Configure the cell with the values of
        let meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating

        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? "") {
        case "AddItem":
            os_log("Adding new meal.", log: OSLog.default, type: .debug)
            
        case "ShowDetail":
            // These three guards are for safety
            guard let mealDetailViewController = segue.destination as? MealViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedMealCell = sender as? MealTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedMeal = meals[indexPath.row]
            mealDetailViewController.meal = selectedMeal
            
        default:
            fatalError("Unexpected Segue Identifier: \(String(describing: segue.identifier))")
        }
        
    }
    
    
    // MARK: Actions
    @IBAction func unwindToMealList(sender: UIStoryboardSegue) {
        
        // try to downcast UIViewController as MealViewController
        if let source = sender.source as? MealViewController, let meal = source.meal {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing meal
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            } else {
                
                // if downcast succesful and not nil, proceed to add new meal
                let newIndexPath = IndexPath(row: meals.count, section: 0)
                
                // add meal to array
                meals.append(meal)
                
                // animates the addition of the new row with 'automatic' animation
                tableView.insertRows(at: [newIndexPath], with: .automatic)
                
            }
        }
    }
    
    // MARK: Private Methods
    private func loadSampleMeals() {
        let photo1 = UIImage(named: "meal1")
        let photo2 = UIImage(named: "meal2")
        let photo3 = UIImage(named: "meal3")
        let photo4 = UIImage(named: "meal4")
    
        guard let meal1 = Meal(name: "Bon Chon Wings", photo: photo1, rating: 5) else {
            fatalError("Could not instantiate meal1")
        }
        
        guard let meal2 = Meal(name: "Chipotle Burrito", photo: photo2, rating: 4) else {
            fatalError("Could not instantiate meal2")
        }
        
        guard let meal3 = Meal(name: "Popeyes Chicken", photo: photo3, rating: 5) else {
            fatalError("Could not instantiate meal3")
        }
        
        guard let meal4 = Meal(name: "Pepperoni Pizza", photo: photo4, rating: 5) else {
            fatalError("Could not instantiate meal4")
        }
        
        meals += [meal1, meal2, meal3, meal4]
    }
}
