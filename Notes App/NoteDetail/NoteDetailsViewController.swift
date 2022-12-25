//
//  NoteDetailsViewController.swift
//  Notes App
//
//  Created by Kennedy Eruba on 21/12/2022.
//

import UIKit
import Combine

class NoteDetailsViewController: UIViewController {
	
	var selectedNote: Note?
	@Published var files = [File]()
	var cancellable = Set<AnyCancellable>()
	
	lazy var viewModel = NoteDetailsViewModel()
	
	@IBOutlet weak var noteTile: UILabel!
	@IBOutlet weak var noteDescription: UILabel!
	@IBOutlet weak var notePriority: UILabel!
	@IBOutlet weak var noteArchived: UILabel!
	@IBOutlet weak var noteCreated: UILabel!
	@IBOutlet weak var noteUpdated: UILabel!
	@IBOutlet weak var filesTableView: UITableView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		setupNavigation()
		registerCell()

		if let note = selectedNote {
			populatedDetails(note)
			
			viewModel.retrieveFiles(noteID: note.id)
				.sink { completion in
					guard case .failure(_) = completion else { return }
				} receiveValue: { [weak self] files in
					self?.files = files
					self?.filesTableView.reloadData()
				}.store(in: &cancellable)
		}
    }
	
	private func setupNavigation() {
		self.navigationItem.title = "Note"
	}
	
	private func populatedDetails(_ note: Note) {
		noteTile.text = note.name
		noteDescription.text = note.description ?? "N/A"
		notePriority.text = String(note.priority)
		noteArchived.text = note.archived! ? "YES" : "NO"
		noteCreated.text = DateUtility.formatDate(note.createdAt)
		noteUpdated.text = DateUtility.formatDate(note.updatedAt)
	}
}

extension NoteDetailsViewController: UITableViewDelegate, UITableViewDataSource {
	
	func registerCell() {
		filesTableView.delegate = self
		filesTableView.dataSource = self
		filesTableView.register(FileItemTableViewCell.nib(), forCellReuseIdentifier: FileItemTableViewCell.cellIdentifier)
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		let pdfFileViewController = PDFFileViewController()
		pdfFileViewController.fileURL = files[indexPath.row].location
		self.navigationController?.pushViewController(pdfFileViewController, animated: true)
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return files.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: FileItemTableViewCell.cellIdentifier, for: indexPath) as! FileItemTableViewCell
		cell.updateFileCell(file: files[indexPath.row])
		return cell
	}
	
}
