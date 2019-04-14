//
//  NotesViewController.swift
//  TestApp
//
//

import UIKit

class NotesViewController: UIViewController {

    //var presenter: INotesPresenter?
    var viewModel: NotesViewModel?
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.getNotes()
        tableView.reloadData()
    }
    
    @IBAction func didTapCreateNote(_ sender: Any) {
        viewModel?.coordinator?.openCreateNote()
    }
}

extension NotesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.notes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let vm = viewModel, let cell = tableView.dequeueReusableCell(withIdentifier: NoteTableViewCell.identifier, for: indexPath) as? NoteTableViewCell else {
            return UITableViewCell()
        }
        
        let note = vm.notes[indexPath.row]
        cell.noteTitleLabel.text = note.noteTitle
        cell.noteDescriptionLabel.text = note.noteText
        cell.dateLabel.text = note.createdDate.getDate()
        cell.monthLabel.text = note.createdDate.getMonth()
        cell.yearLabel.text = note.createdDate.getYear()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let Reject = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            self.viewModel?.deleteNote(index.row)
            tableView.deleteRows(at: [index], with: .bottom)
        }
        Reject.backgroundColor = .red
        return [Reject]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            // handle delete (by removing the data from your array and updating the tableview)
        }
    }
}
