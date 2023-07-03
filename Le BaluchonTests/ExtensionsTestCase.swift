//
//  ExtensionsTestCase.swift
//  Le BaluchonTests
//
//  Created by Charlène JERENT-BELDINEAU on 03/07/2023.
//

@testable import Le_Baluchon
import XCTest

class ExtensionsTestCase: XCTestCase {

    //======================
    // MARK: - String extension
    //======================

    func testGivenStringForUrlHaveSpaceWhenStringEncodeExtensionThenStringHavePercentageEncodingForUrl() {
        
        //When
        var firstCityName: String = "New York"
        var secondCityName: String = "Sao Paulo"
        //When
        let firstCityNameWithEncoding: String = firstCityName.encodeString()
        let secondCityNameWithEncoding: String = secondCityName.encodeString()
        //Then
        XCTAssert(firstCityNameWithEncoding == "New%20York")
        XCTAssert(secondCityNameWithEncoding == "Sao%20Paulo")
        
    }

    func testGivenNumberIsString_WhenStringExtension_ThenStringBecameDouble() {
        
        // Given
        let numberStringComma: String = "50,1"
        let numberStringPoint: String = "50.1"
        let emptyString: String = ""
        //When
        var exNumberStringComma: Double = numberStringComma.doubleValue
        var exNumberStringPoint: Double = numberStringPoint.doubleValue
        var exEmptyString: Double = emptyString.doubleValue
        //Then
        XCTAssert(exNumberStringComma == 50.1)
        XCTAssert(exNumberStringPoint == 50.1)
        XCTAssert(exEmptyString == 0.0)
        
    }
}
