//
//  NotesViewController.swift
//  TestApp
//
//

import UIKit

class NotesViewController: UIViewController {

    //var presenter: INotesPresenter?
    var viewModel: NotesViewModel?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyStateView: UIView!
    
    var editNote: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.getNotes()
        configUI()
        tableView.reloadData()
    }
    
    @IBAction func didTapCreateNote(_ sender: Any) {
        viewModel?.coordinator?.openCreateNote(nil)
    }
    
    func configUI() {
        guard let vm = viewModel else {
            return
        }
        
        searchBar.isHidden = !vm.hasNotes
        tableView.isHidden = !vm.hasNotes
        emptyStateView.isHidden = vm.hasNotes
        
        if vm.hasNotes { tableView.reloadData() }
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
        let reject = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            self.viewModel?.deleteNote(index.row)
            tableView.deleteRows(at: [index], with: .bottom)
            self.configUI()
        }
        reject.backgroundColor = .red
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            self.viewModel?.coordinator?.openCreateNote(self.viewModel?.notes[index.row])
        }
        edit.backgroundColor = .blue
        
        return [reject, edit]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension NotesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchText.isEmpty ? viewModel?.getNotes() : viewModel?.filterNotes(searchText.lowercased())
        searchBar.showsCancelButton = true
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.getNotes()
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
        tableView.reloadData()
    }
}
