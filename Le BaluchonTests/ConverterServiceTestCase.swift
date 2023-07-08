//
//  ConverterServiceTestCase.swift
//  Le BaluchonTests
//
//  Created by Charlène JERENT-BELDINEAU on 25/06/2023.
//

@testable import Le_Baluchon
import XCTest

class ConverterServiceTestCase: XCTestCase {
    
    func testGetConversionShouldPostFailedCallbackIfError() {
        
        // Given
        let converterService = ConverterService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.converterError))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        converterService.getConversion { success, conversion in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(conversion)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetConversionShouldPostFailedCallbackIfNoData() {
        
        // Given
        let converterService = ConverterService(session: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        converterService.getConversion { success, conversion in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(conversion)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetConversionShouldPostFailedCallbackIfIncorrectResponse() {
        
        // Given
        let converterService = ConverterService(session: URLSessionFake(data: FakeResponseData.converterCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        converterService.getConversion { success, conversion in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(conversion)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetConversionShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        
        // Given
        let converterService = ConverterService(session: URLSessionFake(data: FakeResponseData.converterCorrectData, response: FakeResponseData.responseOk, error: nil))
        let numberToConvert: Double = 50.0
        let currencyNameToConvert: String = "EUR"
        let currencyNameConvertTo: String = "USD"
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        converterService.getConversion { (success, conversion) in
            //             Then
            var timestamp: Double?
            var convertResult: [String:Double]?
            
            converterService.reset()
            converterService.addNumberToConvert(from: numberToConvert.toString())
            converterService.addCurrencyNameToConvert(from: currencyNameToConvert)
            
            
            if conversion?.timestamp != nil && conversion?.quotes == nil {
                timestamp = conversion?.timestamp
                convertResult = nil
            } else {
                timestamp = nil
                convertResult = [currencyNameConvertTo: 54.65651658715966]
            }
            
            XCTAssertTrue(success)
            XCTAssertNotNil(conversion)
            
            
            XCTAssertEqual(timestamp, conversion!.timestamp)
            XCTAssertEqual(convertResult, conversion!.quotes)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
}
