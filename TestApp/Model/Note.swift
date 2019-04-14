//
//  Note.swift
//  TestApp
//
//  Created by Gaurav Parvadiya on 2019-04-13.
//  Copyright © 2019 AlayaCare. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }
    
    @NSManaged private var created_date: Date?
    @NSManaged private var text: String?
    @NSManaged private var title: String?
    
    var noteTitle: String {
        get {
            guard let title = self.title else {
                return ""
            }
            
            return title
        }
        
        set {
            title = newValue
        }
    }
    
    
    var noteText: String {
        get {
            guard let text = self.text else {
                return ""
            }
            
            return text
        }
        
        set {
            text = newValue
        }
    }
    
    var createdDate: Date {
        get {
            guard let date = created_date else {
                return Date()
            }
            
            return date
        }
        
        set {
            created_date = newValue
        }
    }
}
