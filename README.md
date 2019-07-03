# [Core Data](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreData/index.html#//apple_ref/doc/uid/TP40001075-CH2-SW1)

> NOTE: Be careful with entity inheritance when working with SQLite persistent stores. All entities that inherit from another entity exist within the same table in SQLite. This factor in the design of the SQLite persistent store can create a performance issue.

## Initializing The Stack

https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreData/InitializingtheCoreDataStack.html#//apple_ref/doc/uid/TP40001075-CH4-SW1

## [Creating and Saving Managed Objects](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreData/CreatingObjects.html#//apple_ref/doc/uid/TP40001075-CH5-SW1)

```swift
let employee = NSEntityDescription.insertNewObjectForEntityForName("Employee", inManagedObjectContext: managedObjectContext) as! EmployeeMO
```

## [Fetching Objects](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreData/FetchingObjects.html#//apple_ref/doc/uid/TP40001075-CH6-SW1)

### `NSFetchRequest`

```swift
var fetchedEmployees: [EmployeeMO]?
do {
  let employeesFetch: NSFetchRequest<EmployeeMO> = EmployeeMO.fetchRequest()
  fetchedEmployees = try context.fetch(employeesFetch)
} catch {
  fatalError("Failed to fetch employees: \(error)")
}
```

**or**

```swift
var fetchedEmployees: [EmployeeMO]?

context.performAndWait {
  let employeesFetch: NSFetchRequest<EmployeeMO> = EmployeeMO.fetchRequest()

  do {
      employees = try context.fetch(employeesFetch)
  } catch {
      fatalError("Failed to fetch employees: \(error)")
  }
}
```

The second option is there for when your context is on another thread. If you're just using the `viewContext`, then don't worry about the second way.

```swift
// NSPredicate
let firstName = "Trevor"
employeesFetch.predicate = NSPredicate(format: "firstName == %@", firstName)
```


### NSFetchedResultsController