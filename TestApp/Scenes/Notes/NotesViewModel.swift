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
    func openCreateNote(_ toEditNote: Note?)
}

class NotesViewModel {
    var notes: [Note] = []
    var allNotes: [Note] = []
    var context: NSManagedObjectContext
    weak var coordinator: NotesCoordinatorDelegate?
    
    var hasNotes: Bool {
        return allNotes.count > 0
    }
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func getNotes() {
        let request: NSFetchRequest<Note> = Note.fetchRequest()
        do {
            notes = try context.fetch(request)
            allNotes = notes
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
    
    func filterNotes(_ searchText: String) {
        notes = allNotes.filter({ (note: Note) -> Bool in
            return note.noteText.lowercased().contains(searchText) ||
                note.noteTitle.lowercased().contains(searchText)
        })
    }
}
