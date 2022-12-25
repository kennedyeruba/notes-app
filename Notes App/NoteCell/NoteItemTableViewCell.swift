//
//  NoteItemTableViewCell.swift
//  Notes App
//
//  Created by Kennedy Eruba on 21/12/2022.
//

import UIKit

class NoteItemTableViewCell: UITableViewCell {
	
	static let cellIdentifier = "NoteCell"
	
	@IBOutlet weak var noteTitle: UILabel!
	@IBOutlet weak var container: UIView!
	@IBOutlet weak var noteCreated: UILabel!
	@IBOutlet weak var noteArchived: UILabel!
	@IBOutlet weak var notePriority: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
    }
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
	static func nib() -> UINib {
		return UINib(nibName: "NoteItemTableViewCell", bundle: nil)
	}
	
	func modifyNoteCell() {
		container.layer.cornerRadius = 10.0
		container.layer.masksToBounds = false
		container.layer.shadowColor = UIColor.black.cgColor
		container.layer.shadowOpacity = 0.2
		container.layer.shadowOffset = CGSize(width: 0, height: 0)
		container.layer.shadowRadius = 2
	}
	
	func updateNoteCell(note: Note) {
		noteTitle.text = note.name
		noteArchived.text = note.archived! ? "YES" : "NO"
		notePriority.text = String(note.priority)
		noteCreated.text = DateUtility.formatDate(note.createdAt)
		modifyNoteCell()
	}
}
