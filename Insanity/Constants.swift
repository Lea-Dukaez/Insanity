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
        static let leaAvatar = "LeaAvatar"
        static let malekAvatar = "MalekAvatar"
        static let mathAvatar = "MathAvatar"
        static let louxAvatar = "LouxAvatar"
        static let leaLabel = "Lea, fit Courgette"
        static let malekLabel = "Malfouf, le Nul"
        static let mathLabel = "Mathou, super Blonde"
        static let louxLabel = "Loux, nihon Kyojin"
        static let usersAvatar = ["MalekAvatar", "LeaAvatar", "MathAvatar", "LouxAvatar"]
        static let usersLabel = ["Malfouf, le Nul", "Lea, fit Courgette", "Mathou, super Blonde", "Loux, nihon Kyojin"]

    }
    
    struct workout {
        static let workoutMove = ["Switch Kicks", "Power Jack", "Power Knees", "Power Jump", "Jump Squat Square", "Suicide Jump", "Push-Up Jack", "Plank Mountain Climbers" ]
        static let workoutCellIdentifier = "workoutMoveCell"
        static let workoutCellNibName = "WorkoutCell"
    }
    
    struct FStore {
        static let collectionName = "workoutTest"
        static let dateField = "date"
        static let userField = "user"
        static let testField = "testArray"
        static let malekUser = "Malek"
        static let leaUser = "Lea"
        static let mathUser = "Math"
        static let louxUser = "Loux"
        static let users = ["Malek", "Lea", "Math", "Loux"] // same as leaUser and malekUser and mathUser in array
    }
    

        



}
