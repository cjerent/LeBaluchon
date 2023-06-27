//
//  ConverterServiceTestCase.swift
//  Le BaluchonTests
//
//  Created by Charlène JERENT-BELDINEAU on 25/06/2023.
//

@testable import Le_Baluchon
import XCTest

class ConverterServiceTestCase: XCTestCase {
    
    
    func testGetConversionShouldPostFailesCallbackIfError() {
        
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
//        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetConversionShouldPostFailesCallbackIfNoData() {
        
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
//        wait(for: [expectation], timeout: 0.01)
        
    }

    func testGetConversionShouldPostFailesCallbackIfIncorrectResponse() {
        
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
//        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetConversionShouldPostFailesCallbackIfIncorrectData() {
        
    // Given
        let converterService = ConverterService(session: URLSessionFake(data: FakeResponseData.converterIncorrectData, response: FakeResponseData.responseOk, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        converterService.getConversion { success, conversion in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(conversion)
            expectation.fulfill()
        }
//        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGetConversionShouldPostSucessCallbackIfNoErrorAndCorrectData() {

    // Given
        let converterService = ConverterService(session: URLSessionFake(data: FakeResponseData.converterCorrectData, response: FakeResponseData.responseOk, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        converterService.getConversion { success, conversion in
            // Then
            let currency = ["USDEUR":0.914804]
            let timestamp = 1687684683.0

            XCTAssertTrue(success)
            XCTAssertNotNil(conversion)

            XCTAssertEqual(currency, conversion!.quotes)
            XCTAssertEqual(timestamp, conversion!.timestamp)

            expectation.fulfill()
        }
//        wait(for: [expectation], timeout: 0.01)

    }
    

}
