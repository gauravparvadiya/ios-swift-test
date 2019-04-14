//
//  CreateNoteViewModel.swift
//  TestApp
//
//  Created by Gaurav Parvadiya on 2019-04-13.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import Foundation
import CoreData

class CreateNoteViewModel {
    var context: NSManagedObjectContext
    var toEditNote: Note?
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func createNote(title: String, text: String) {
        let note = Note(context: context)
        note.noteTitle = title
        note.noteText = text
        note.createdDate = Date()
        
        do {
            try context.save()
        } catch let error as NSError  {
            print("\(error). \(error.userInfo)")
        }
    }
    
    func editNote(title: String, text: String) {
        guard let note = toEditNote else {
            return
        }
        note.noteTitle = title
        note.noteText = text
        
        do {
            try context.save()
            toEditNote = nil
        } catch let error as NSError  {
            print("\(error). \(error.userInfo)")
        }
    }
}
