//
//  APICaller.swift
//  Notes App
//
//  Created by Kennedy Eruba on 22/12/2022.
//

import Foundation
import Combine

class APICaller: NSObject {
	var cancellable: AnyCancellable?
	static let shared = APICaller()
	let sharedSession = URLSession.shared
	let baseUrlString = "https://api.pwdevtest.com"
	
	func getNotes(_ endpoint: String) -> AnyPublisher<[Note], Error> {
		return sharedSession.dataTaskPublisher(for: URL(string: "\(baseUrlString)\(endpoint)")!)
			.catch { error in
				return Fail(error: error).eraseToAnyPublisher()
			}
			.map({ $0.data })
			.decode(type: [Note].self, decoder: JSONDecoder())
			.receive(on: DispatchQueue.main)
			.eraseToAnyPublisher()
	}
	
	func getFiles(_ endpoint: String) -> AnyPublisher<[File], Error> {
		return sharedSession.dataTaskPublisher(for: URL(string: "\(baseUrlString)\(endpoint)")!)
			.catch { error in
				return Fail(error: error).eraseToAnyPublisher()
			}
			.map({ $0.data })
			.decode(type: [File].self, decoder: JSONDecoder())
			.receive(on: DispatchQueue.main)
			.eraseToAnyPublisher()
	}
}
