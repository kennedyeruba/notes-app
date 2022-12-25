//
//  FileItemTableViewCell.swift
//  Notes App
//
//  Created by Kennedy Eruba on 22/12/2022.
//

import UIKit

class FileItemTableViewCell: UITableViewCell {
	
	static let cellIdentifier = "FileCell"

	@IBOutlet weak var dateUploaded: UILabel!
	@IBOutlet weak var fileName: UILabel!
	@IBOutlet weak var container: UIView!
	
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
		return UINib(nibName: "FileItemTableViewCell", bundle: nil)
	}
    
	func modifyFileCell() {
		container.layer.cornerRadius = 10.0
		container.layer.masksToBounds = false
		container.layer.shadowColor = UIColor.black.cgColor
		container.layer.shadowOpacity = 0.2
		container.layer.shadowOffset = CGSize(width: 0, height: 0)
		container.layer.shadowRadius = 2
	}
	
	func updateFileCell(file: File) {
		fileName.text = file.name
		dateUploaded.text = DateUtility.formatDate(file.uploadedAt)
		modifyFileCell()
	}
}
