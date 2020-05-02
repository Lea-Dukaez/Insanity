//
//  File.swift
//  Insanity
//
//  Created by Léa on 24/04/2020.
//  Copyright © 2020 Lea Dukaez. All rights reserved.
//

struct K {
    static let appName = "INSANITY"
    static let segueToProgress = "goToProgress"
    
    struct BrandColor {
        static let blueGreyBrandColor = "BlueGreyBrandColor"
        static let greenBrandColor = "GreenBrandColor"
    }
    
    struct userCell {
        static let userCellIdentifier = "myReusableCell"
        static let userCellNibName = "UserCell"
        static let noOpponentAvatar = "noOpponentAvatar"
        static let usersAvatar = ["MalekAvatar", "LeaAvatar", "MathAvatar", "LouxAvatar"]
        static let usersLabel = ["Malfouf, le Nul", "Lea, fit Courgette", "Mathou, super Blonde", "Loux, nihon Kyojin"]
    }
    
    struct workout {
        static let workoutMove = ["Switch Kicks", "Power Jack", "Power Knees", "Power Jump", "Jump Squat Square", "Suicide Jump", "Push-Up Jack", "Plank Mountain Climbers" ]
        static let workoutCellIdentifier = "workoutMoveCell"
        static let workoutCellNibName = "WorkoutCell"
    }
    
    struct FStore {
        static let collectionTestName = "workoutTests"
        static let dateField = "date"
        static let idField = "id"
        static let testField = "testResults"
        static let collectionUsersName = "users"
        static let nameField = "name"
        static let maxField  = "max"
        static let users = ["Malek", "Lea", "Math", "Loux"]
    }
    

        



}
