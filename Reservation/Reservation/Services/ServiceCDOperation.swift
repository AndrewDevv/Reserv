//
//  ServiceCD.swift
//  Reservation
//
//  Created by Андрей Антонов on 07.10.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import UIKit
import CoreData

final class ServiceCoreDataOperation {
    private let operation = OperationQueue()
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func saveUser(user: [User]) {
        operation.addOperation {
            do {
                let context = self.appDelegate.persistentContainer.viewContext
                
                user.forEach { (data) in
                    let userEntity = Users(context: context)
                    userEntity.firstName = data.firstName
                    userEntity.lastName = data.lastName
                    userEntity.country = data.country
                    userEntity.city = data.city
                    userEntity.yearOfBrith = data.yearOfBrith
                    
                    let petEntity = Pets(context: context)
                    petEntity.name = data.pet.name
                    petEntity.color = data.pet.color
                    petEntity.legs = data.pet.legs
                    petEntity.eye = data.pet.eye
                    
                    userEntity.pets = petEntity
                    
                    let numberEntity = NumbersPhone(context: context)
                    data.numbers.forEach { (number) in
                        numberEntity.personalNumber = number.personalNumber
                        numberEntity.homeNumber = number.homeNumber
                    }
                    
                    userEntity.phoneNumbers = numberEntity
                }
                try context.save()
            } catch {
                print(EntityError.entityNotFound)
            }
        }
    }
    
    func readUser(closure: @escaping ([User]) -> Void) {
        operation.addOperation {
            let context = self.appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: String(describing: Users.self))
            do {
                let fetchData = try context.fetch(fetchRequest)
                if let userData = fetchData as? [Users] {
                    let user = userData.map { (data) -> User in
                        let firstName = data.firstName
                        let lastName = data.lastName
                        let country = data.country
                        let city = data.city
                        let yearOfBrith = data.yearOfBrith
                        let name = data.pets?.name
                        let color = data.pets?.color
                        let legs = data.pets?.legs
                        let eye = data.pets?.eye
                        let personalNumber = data.phoneNumbers?.personalNumber
                        let homeNumber = data.phoneNumbers?.homeNumber
                        return User(
                            firstName: firstName!,
                            lastName: lastName!,
                            country: country!,
                            city: city!,
                            yearOfBrith: yearOfBrith,
                            pet: User.Pet(name: name!, color: color!, legs: legs!, eye: eye!),
                            numbers: [User.Numbers(personalNumber: personalNumber!, homeNumber: homeNumber!)]
                        )
                    }
                    closure(user)
                }
            } catch let error as NSError{
                print(error)
            }
        }
    }
}
