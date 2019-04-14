//
//  CreateNoteViewController.swift
//  TestApp
//
//  Created by Gaurav Parvadiya on 2019-04-13.
//  Copyright © 2019 AlayaCare. All rights reserved.
//

import UIKit

class CreateNoteViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var createNoteButton: UIButton!
    
    var viewModel: CreateNoteViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let note = viewModel?.toEditNote {
            titleTextField.text = note.noteTitle
            descriptionTextField.text = note.noteText
            createNoteButton.setTitle("Edit", for: .normal)
        }
    }
    
    @IBAction func didTapBack(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func didTapAddNote(_ sender: Any) {
        guard let title = titleTextField.text, !descriptionTextField.text.isEmpty else {
            let alertController = UIAlertController(title: "Error", message: "Both title and text is required field.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        ((viewModel?.toEditNote) != nil) ? viewModel?.editNote(title: title, text: descriptionTextField.text) : viewModel?.createNote(title: title, text: descriptionTextField.text)
        titleTextField.text = nil
        descriptionTextField.text = ""
        self.navigationController?.popViewController(animated: true)
    }
}
