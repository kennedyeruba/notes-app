//
//  DateUtility.swift
//  Notes App
//
//  Created by Kennedy Eruba on 23/12/2022.
//

import Foundation

class DateUtility: NSObject {
	static func formatDate(_ isoTime: String) -> String {
		let isodDateFormatter = ISO8601DateFormatter()
		isodDateFormatter.formatOptions.insert(.withFractionalSeconds)
		
		let formatter = DateFormatter()
		formatter.locale = .current
		formatter.timeZone = .current
		formatter.dateFormat = "dd/MM/yyyy"
		return formatter.string(from: isodDateFormatter.date(from: isoTime)!)
	}
}
