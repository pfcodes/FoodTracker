//
//  Meal.swift
//  FoodTracker
//
//  This is the data model for Meal instances
//
//  Created by Phil on 11/6/17.
//  Copyright © 2017 phlfvry. All rights reserved.
//

import UIKit

class Meal {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int) {

        // Name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // Rating must be between 0 and 5 inclusive
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        
        // Initialize stored properties
        self.name = name
        self.photo = photo
        self.rating = rating
        
    }
    
}
