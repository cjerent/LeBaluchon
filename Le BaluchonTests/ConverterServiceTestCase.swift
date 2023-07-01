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
        wait(for: [expectation], timeout: 0.01)
        
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

    
    
    func testGetConversionShouldPostSucessCallbackIfNoErrorAndCorrectData() {

    // Given
        let converterService = ConverterService(session: URLSessionFake(data: FakeResponseData.converterCorrectData, response: FakeResponseData.responseOk, error: nil))
        let numberToConvert = 50.0
        let currencyNameToConvert = "EUR"
        let currencyNameConvertTo = "USD"
        
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        converterService.getConversion { (success, conversion) in
        
//             Then
            converterService.reset()
            converterService.addNumberToConvert(from: String(numberToConvert))
            converterService.addCurrencyNameToConvert(from: currencyNameToConvert)
            
            converterService.calculateConversionRate(with: 0.914804)
            // faire une boucle comme dans converterService ? 
            XCTAssertTrue(success)
            XCTAssertNotNil(conversion)
            
            let result = [currencyNameConvertTo: 54.6565166]
            let timestamp = 1687684683.0
            
            expectation.fulfill()
            XCTAssertEqual(result, ["USD" : 54.6565166])
            XCTAssertEqual(timestamp, conversion!.timestamp)

            
        }
        wait(for: [expectation], timeout: 0.01)

    }
    

}
