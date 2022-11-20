//
//  ServiceSaveCoreData.swift
//  Reservation
//
//  Created by Андрей Антонов on 18.08.2021.
//  Copyright © 2021 Андрей Антонов. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

enum EntityError: Error {
    case entityNotFound
}

final class ServiceCoreData {
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func saveUser(user: [User]) -> Observable<Void> {
        return Observable.create { (observer) in
            do {
                let context = self.appDelegate.persistentContainer.viewContext
                
                let usersEntity = Users(context: context)
                user.forEach { (data) in
                    usersEntity.firstName = data.firstName
                    usersEntity.lastName = data.lastName
                    usersEntity.country = data.country
                    usersEntity.city = data.city
                    usersEntity.yearOfBrith = data.yearOfBrith
                    
                    let petsEntity = Pets(context: context)
                    petsEntity.name = data.pet.name
                    petsEntity.color = data.pet.color
                    petsEntity.legs = data.pet.legs
                    petsEntity.eye = data.pet.eye
                    
                    usersEntity.pets = petsEntity
                    
                    let numbersEntity = NumbersPhone(context: context)
                    data.numbers.forEach { (number) in
                        numbersEntity.personalNumber = number.personalNumber
                        numbersEntity.homeNumber = number.homeNumber
                    }
                    
                    usersEntity.phoneNumbers = numbersEntity
                }
                try context.save()
                observer.onNext(())
                observer.onCompleted()
            } catch let error as NSError {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func readUser() -> Observable<[User]> {
        return Observable.create { (observer) in
            let context = self.appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: String(describing: Users.self))
            do {
                let fetchData = try context.fetch(fetchRequest)
                if let users = fetchData as? [Users] {
                    let userData = users.map { (data) -> User in
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
                    observer.onNext(userData)
                    observer.onCompleted()
                }
            } catch let error as NSError {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func saveOfficeData(offices: [Office]) -> Observable<Void> {
        return Observable.create { (observer) -> Disposable in
            let context = self.appDelegate.persistentContainer.viewContext
            for office in offices {
                if let entity = NSEntityDescription.entity(forEntityName: "Offices", in: context) {
                    let newOffice = NSManagedObject(entity: entity, insertInto: context)
                    
                    newOffice.setValue(office.name, forKey: "name")
                    newOffice.setValue(office.number, forKey: "number")
                } else {
                    observer.onError(EntityError.entityNotFound)
                }
            }
            do {
                try context.save()
                observer.onNext(())
                observer.onCompleted()
            } catch let error as NSError {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func readOfficeData() -> Observable<[Office]> {
        return Observable.create{ (observer) in
            let context = self.appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: String(describing: Offices.self))
            let sortDescriptor = NSSortDescriptor(key: "number", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            do {
                let fetchData = try context.fetch(fetchRequest)
                let officeData = fetchData.map { data -> Office in
                    let name = data.value(forKey: "name") as! String
                    let number = data.value(forKey: "number") as! Int32
                    return Office(number: number, name: name)
                }
                observer.onNext(officeData)
                observer.onCompleted()
            } catch let error as NSError {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func saveRoomsData(rooms: [RoomsJSON]) -> Observable<Void> {
        return Observable.create { observer in
            let context = self.appDelegate.persistentContainer.viewContext
            for room in rooms {
                if let entity = NSEntityDescription.entity(forEntityName: "RoomsData", in: context) {
                    let setRoom = NSManagedObject(entity: entity, insertInto: context)
                    
                    setRoom.setValue(room.name, forKey: "name")
                    setRoom.setValue(room.isAvailable, forKey: "isAvailable")
                } else {
                    observer.onError(EntityError.entityNotFound)
                }
            }
            do {
                try context.save()
                observer.onNext(())
                observer.onCompleted()
            } catch let error as NSError {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func readRoomsData() -> Observable<[RoomsJSON]> {
        return Observable.create { observer in
            let context = self.appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: String(describing: RoomsData.self))
            do {
                let resultData = try context.fetch(fetchRequest)
                let resultRooms = resultData.map { data -> RoomsJSON in
                    let name = data.value(forKey: "name") as! String
                    let isAvailable = data.value(forKey: "isAvailable") as! Bool
                    return RoomsJSON(name: name, isAvailable: isAvailable)
                }
                observer.onNext(resultRooms)
                observer.onCompleted()
            } catch let error as NSError {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func saveWorkplaceData(workplace: [WorkPlace]) -> Observable<Void> {
        return Observable.create { observer in
            let context = self.appDelegate.persistentContainer.viewContext
            for work in workplace {
                if let entity = NSEntityDescription.entity(forEntityName: "WorkPlaceData", in: context) {
                    let setWorkplace = NSManagedObject(entity: entity, insertInto: context)
                    
                    setWorkplace.setValue(work.name, forKey: "name")
                    setWorkplace.setValue(work.number, forKey: "number")
                    setWorkplace.setValue(work.isAvailable, forKey: "isAvailable")
                } else {
                    observer.onError(EntityError.entityNotFound)
                }
            }
            do {
                try context.save()
                observer.onNext(())
                observer.onCompleted()
            } catch let error as NSError {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    func readWorkplaceData() -> Observable<[WorkPlace]> {
        return Observable.create { observer in
            let context = self.appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: String(describing: WorkPlaceData.self))
            let sortDescriptor = NSSortDescriptor(key: "number", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]
            do {
                let resultData = try context.fetch(fetchRequest)
                let resultWorkplace = resultData.map { data -> WorkPlace in
                    let name = data.value(forKey: "name") as! String
                    let number = data.value(forKey: "number") as! String
                    let isAvailable = data.value(forKey: "isAvailable") as! Bool
                    return WorkPlace(name: name, number: number, isAvailable: isAvailable)
                }
                observer.onNext(resultWorkplace)
                observer.onCompleted()
            } catch let error as NSError {
               observer.onError(error)
            }
            return Disposables.create()
        }
    }
}
