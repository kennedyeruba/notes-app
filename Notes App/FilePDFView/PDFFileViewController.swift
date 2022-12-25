//
//  PDFFileViewController.swift
//  Notes App
//
//  Created by Kennedy Eruba on 22/12/2022.
//

import UIKit
import PDFKit
import Combine

class PDFFileViewController: UIViewController {
	
	private let pdfView = PDFView()
	var fileURL: String = ""
	@Published var document: PDFDocument?
	private var cancellable = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
		view.addSubview(pdfView)
		
		guard let url = URL(string: fileURL) else { return }
		
		DispatchQueue.global(qos: .background).async {
			self.document = PDFDocument(url: url)
		}
		
		$document
			.receive(on: DispatchQueue.main)
			.sink(receiveValue: { document in
				self.pdfView.document = document
			}).store(in: &cancellable)
    }
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		pdfView.frame = view.bounds
	}
}
