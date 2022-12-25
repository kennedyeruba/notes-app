//
//  NotesListViewModel.swift
//  Notes App
//
//  Created by Kennedy Eruba on 22/12/2022.
//

import UIKit
import Combine

class NotesListViewModel: NSObject {
	
	override init() {}
	
	func retrieveNotes() -> AnyPublisher<[Note], Error> {
		let endpoint = "/records"
		return APICaller.shared.getNotes(endpoint)
	}
}
