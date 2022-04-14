//
//  TableViewExampleTests.swift
//  TableViewExampleTests
//
//  Created by Shaik, Suneelahammad (Cognizant) on 13/04/22.
//

import XCTest
@testable import TableViewExample

class TableViewExampleTests: XCTestCase {
    
    var mockServiceManager: MockServiceManager!
    var viewModel: DrinksViewModel!
    var cellIndex: Int?
    weak var cellDelegate: DrinksTableViewCellProtocol?
    var expectation: XCTestExpectation?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        mockServiceManager = MockServiceManager()
        viewModel = DrinksViewModel(service: mockServiceManager)
        cellDelegate = self
        
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        mockServiceManager = nil
        viewModel = nil
        
        try super.tearDownWithError()
    }
    
    func testServiceAPI_Success() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let expectation = expectation(description: "Drinks should be loaded")
        
        mockServiceManager.jsonString = "{\"drinks\": [{\"strDrink\": \"Margarita One\",\"strCategory\": \"Ordinary Drink\",\"strAlcoholic\": \"Alcoholic\", \"strDrinkThumb\": \"https:\\/\\/www.thecocktaildb.com\\/images\\/media\\/drink\\/bry4qh1582751040.jpg\"}]}"
        
        viewModel.callService { [weak self] isSuccess in
            XCTAssertTrue(isSuccess, "Drinks data is available")
            XCTAssertEqual(self?.viewModel.drinks?.count, 1, "Drink count should be 1")
            XCTAssertEqual(self?.viewModel.getNoOfRows(), 1, "Rows count should be 1")
            XCTAssertEqual(self?.viewModel.getDrink(index: 0)?.strDrink, "Margarita One", "Rows count should be 1")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    func testServiceAPI_Failure() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let expectation = expectation(description: "Drinks should be available")
        
        mockServiceManager.jsonString = "{\"drinks\": [{\"strDr\": \"Margarita One\",\"strCategory\": \"Ordinary Drink\",\"strAlcoholic\": \"Alcoholic\", \"strDrinkThumb\": \"https:\\/\\/www.thecocktaildb.com\\/images\\/media\\/drink\\/bry4qh1582751040.jpg\"}]}"
        
        viewModel.callService { isSuccess in
            XCTAssertFalse(isSuccess, "Drinks data is not available")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    func testHeadetTitle_Success() {
        XCTAssertEqual(self.viewModel.getHeaderTitle(), "Drinks", "Header title should be Drinks")
    }
    
    func testTappedCellIndex() throws {
        expectation = expectation(description: "Tapped cell index is captured")
        cellDelegate?.tappedCell(index: 1)
        XCTAssertEqual(try? XCTUnwrap(cellIndex), 1, "Tapped cell is correct")
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testDrinkType_Alcohol_Few() throws {
        
        let drinkType = self.viewModel.getDrinkType(index: 0)
        if case drinkType = DrinkType.alcohol(.few) {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
    
    func testDrinkType_Alcohol_All() throws {
        
        let drinkType = self.viewModel.getDrinkType(index: 6)
        if case drinkType = DrinkType.alcohol(.all) {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
    }
}

extension TableViewExampleTests: DrinksTableViewCellProtocol {

    func tappedCell(index: Int) {
        cellIndex = index
        expectation?.fulfill()
    }
}
