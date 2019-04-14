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
    
    var viewModel: CreateNoteViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        viewModel?.createNote(title: title, text: descriptionTextField.text)
        titleTextField.text = nil
        descriptionTextField.text = ""
    }
}
