//
//  DataManager.swift
//  Genius
//
//  Created by Sam Meech-Ward on 2019-07-03.
//  Copyright © 2019 meech-ward. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
  
  static let shared = DataManager()
  
  // The persistent container manages the core data stack for us
  // Without this, we would have to do a bunch of setup manually
  // https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreData/InitializingtheCoreDataStack.html#//apple_ref/doc/uid/TP40001075-CH4-SW1
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Genius")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  
  var viewContext: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  var backgroundContext: NSManagedObjectContext {
    let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
    context.parent = viewContext
    return context
  }
  
  // MARK: - Core Data Saving support
  
  func saveContext () {
    let context = viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
  func getQuizzes() throws -> [Quiz] {
    // Like creating a sql query
    let fetch: NSFetchRequest<Quiz> = Quiz.fetchRequest()
    
    // Executing the query
    return try viewContext.fetch(fetch)
  }
  
  func getQuestions(category: String) throws -> [Question] {
    // Like creating a sql query
    let fetch: NSFetchRequest<Question> = Question.fetchRequest()

    fetch.predicate = NSPredicate(format: "category == %@", category)
    
    // Executing the query
    return try viewContext.fetch(fetch)
  }
  
  func getQuizzes2(completion: @escaping ([Quiz]) -> ()) {
    // Like creating a sql query
    let fetch: NSFetchRequest<Quiz> = Quiz.fetchRequest()

    backgroundContext.perform {
      // All of this happens on a background queue, so be careful
      let quizzes = try! fetch.execute()
      completion(quizzes)
    }
  }
}
