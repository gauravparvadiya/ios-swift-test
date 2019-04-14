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
}
