//
//  Notes_AppUITests.swift
//  Notes AppUITests
//

//  Created by Kennedy Eruba on 21/12/2022.
//

import XCTest

final class Notes_AppUITests: XCTestCase {
	
	override class func setUp() {}

	func testAddNote() {
		let app = XCUIApplication()
		let addNoteButton = app.buttons["Add Note"]
		let dialogMessage = app.staticTexts["Pending Feature"]
		
		app.launch()
		addNoteButton.tap()
		
		XCTAssert(dialogMessage.waitForExistence(timeout: 0.5))
	}
	
	func testNavigationToDetailsPage() {
		let app = XCUIApplication()
		let notesTableCell = app.tables["NotesTable"].cells.element(boundBy: 0)
		let noteNavBarTitle = app.staticTexts["Note"]
		
		app.launch()
		notesTableCell.tap()
		
		XCTAssert(noteNavBarTitle.waitForExistence(timeout: 0.5))
	}
	
	func testAccessRecordFile() {}
}
