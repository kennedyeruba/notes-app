//
//  NoteDetailsViewModel.swift
//  Notes App
//
//  Created by Kennedy Eruba on 21/12/2022.
//

import Foundation
import Combine

class NoteDetailsViewModel: NSObject {
	
	override init() {}
	
	func retrieveFiles(noteID: Int) -> AnyPublisher<[File], Error> {
		let endpoint = "/records/\(noteID)/files"
		return APICaller.shared.getFiles(endpoint)
	}
}
