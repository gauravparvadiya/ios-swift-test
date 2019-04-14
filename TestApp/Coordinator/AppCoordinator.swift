//
//  AppCoordinator.swift
//  TestApp
//
//  Created by Gaurav Parvadiya on 2019-04-13.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AppCoordinator: NSObject, Coordinator {
    
    var window: UIWindow
    let application: UIApplication
    var persistentContainer: NSPersistentContainer
    let context: NSManagedObjectContext
    
    init(window: UIWindow, application: UIApplication, persistentContainer: NSPersistentContainer) {
        self.window = window
        self.application = application
        self.persistentContainer = persistentContainer
        self.context = persistentContainer.viewContext
        super.init()
    }
    
    func start() {
        let vc  = StoryboardScene.Main.notesViewController.instantiate()
        vc.viewModel = NotesViewModel(context: context)
        vc.viewModel?.coordinator = self
        show(viewController: UINavigationController(rootViewController: vc), window: &window, shouldNavigate: false)
    }
}

extension AppCoordinator: NotesCoordinatorDelegate {
    func openCreateNote() {
        let vc  = StoryboardScene.Main.createNoteViewController.instantiate()
        vc.viewModel = CreateNoteViewModel(context: context)
        show(viewController: vc, window: &window, shouldNavigate: true)
    }
}
