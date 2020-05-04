//
//  CoreDataPersistence.swift
//  Movies
//
//  Created by Khurram on 03/05/2020.
//  Copyright © 2020 Example. All rights reserved.
//

import CoreData
import Foundation

final class CoreDataPersistence {
  
private let dispatchQueue = DispatchQueue(label: "com.example.Movies.CoreDataPersistence.DispatchQueue")
private let persistentContainer: NSPersistentContainer
  
init(persistentContainer: NSPersistentContainer) {
  self.persistentContainer = persistentContainer
}
}

extension CoreDataPersistence: Persistence {
func persist(movies: [Movie]) {
  let context = persistentContainer.newBackgroundContext()
  dispatchQueue.async {
    self.persist(movies: movies, using: context)
  }
}

func search(query: String, comepletion: @escaping([Movie]) -> Void) {
  let context = persistentContainer.newBackgroundContext()
  dispatchQueue.async {
    let titlePredicate = NSPredicate(format: "title CONTAINS[cd] %@", query)
    let overviewPredicate = NSPredicate(format: "overview CONTAINS[cd] %@", query)
    let predicate = NSCompoundPredicate(orPredicateWithSubpredicates: [titlePredicate, overviewPredicate])
    let movies = self.fetch(with: predicate, using: context).map { $0.toMovie() }
    DispatchQueue.main.async {
      comepletion(movies)
    }
  }
}
}

extension CoreDataPersistence {
private func persist(movies: [Movie], using context: NSManagedObjectContext) {
  for movie in movies {
    let movieEntity: MovieEntity
    if let existing = get(with: movie.id, using: context) {
      movieEntity = existing
    } else {
      movieEntity = NSEntityDescription.insertNewObject(forEntityName: "MovieEntity", into: context) as! MovieEntity
    }
    movieEntity.update(with: movie)
  }
  context.saveChanges()
}
private func get(with id: Int, using context: NSManagedObjectContext) -> MovieEntity? {
  fetch(with: NSPredicate(format: "id == %d", id), using: context).first
}
private func fetch(with predicate: NSPredicate, using context: NSManagedObjectContext) -> [MovieEntity] {
  let fetchRequest: NSFetchRequest = MovieEntity.fetchRequest()
  fetchRequest.predicate = predicate
  do {
    return try context.fetch(fetchRequest)
  } catch {
    _ = handleError(error)
  }
  return []
}
}

extension NSManagedObjectContext {
func saveChanges() {
  if !hasChanges {
    return
  }
  do {
    try save()
  } catch {
    _ = handleError(error)
  }
}
}
