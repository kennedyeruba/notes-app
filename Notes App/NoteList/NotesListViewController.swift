//
//  NotesListViewController.swift
//  Notes App
//
//  Created by Kennedy Eruba on 21/12/2022.
//

import UIKit
import Combine

class NotesListViewController: UIViewController {
	
	@Published var notes = [Note]()
	var cancellable = Set<AnyCancellable>()
	lazy var viewModel = NotesListViewModel()
	
	@IBOutlet weak var notesTableView: UITableView!

	override func viewDidLoad() {
		super.viewDidLoad()
		self.notesTableView.accessibilityIdentifier = "NotesTable"
		viewModel.retrieveNotes()
			.sink { completion in
				guard case .failure(_) = completion else { return }
			} receiveValue: { [weak self] notes in
				self?.notes = notes
				self?.notesTableView.reloadData()
			}.store(in: &cancellable)
		
		setupNavigation()
		registerCell()
	}
	
	private func setupNavigation() {
		self.navigationItem.title = "Notes"
	}
	
	@IBAction func onTapAddNote() {
		let alert = UIAlertController(title: "Add Note", message: "Pending Feature", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "ok", style: .default))
		self.present(alert, animated: true)
	}

}

extension NotesListViewController: UITableViewDelegate, UITableViewDataSource {
	
	func registerCell() {
		notesTableView.delegate = self
		notesTableView.dataSource = self
		notesTableView.register(NoteItemTableViewCell.nib(), forCellReuseIdentifier: NoteItemTableViewCell.cellIdentifier)
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let storyBoard = UIStoryboard(name: "Main", bundle: nil)
		let noteDetailsViewController = storyBoard.instantiateViewController(withIdentifier: "NoteDetailsViewController") as! NoteDetailsViewController
		noteDetailsViewController.selectedNote = notes[indexPath.row]
		self.navigationController?.pushViewController(noteDetailsViewController, animated: true)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return notes.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: NoteItemTableViewCell.cellIdentifier, for: indexPath) as! NoteItemTableViewCell
		cell.updateNoteCell(note: notes[indexPath.row])
		return cell
	}
	
}
