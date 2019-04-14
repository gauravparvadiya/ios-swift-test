//
//  NotesPresenter.swift
//  TestApp
//
//

import Foundation
import CoreData

protocol INotesPresenter {

}

protocol NotesCoordinatorDelegate: class {
    func openCreateNote()
}

class NotesViewModel {
    var notes: [Note] = []
    var context: NSManagedObjectContext
    weak var coordinator: NotesCoordinatorDelegate?
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func getNotes() {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        do {
           notes = try context.fetch(request)
        } catch {
            print("Problem fetching notes.")
        }
    }
    
    func deleteNote(_ index: Int) {
        context.delete(notes[index])
        do {
            try context.save()
            getNotes()
        } catch let error as NSError {
            print("\(error). \(error.userInfo)")
        }
    }
}
