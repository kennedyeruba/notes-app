//
//  DataModels.swift
//  Notes App
//
//  Created by Kennedy Eruba on 21/12/2022.
//

import Foundation

struct Note: Codable {
	var id: Int
	var key: String
	var name: String
	var description: String?
	var priority: Int
	var archived: Bool?
	var updatedAt: String
	var createdAt: String
}

struct File: Codable {
	var id: Int
	var key: String
	var name: String
	var size: Int
	var location: String
	var uploadedAt: String
}
