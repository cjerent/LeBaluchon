//
//  TranslationServiceTestCase.swift
//  Le BaluchonTests
//
//  Created by Charlène JERENT-BELDINEAU on 25/06/2023.
//

@testable import Le_Baluchon
import XCTest

class TranslationServiceTestCase: XCTestCase {

    func testGetTranslationShouldPostFailesCallbackIfError() {
        
    // Given
        let translationService = TranslationService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.translationError))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation { success, translation in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetTranslationShouldPostFailesCallbackIfNoData() {
        
    // Given
        let translationService = TranslationService(session: URLSessionFake(data: nil, response: nil, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation { success, translation in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }

    func testGetTranslationShouldPostFailesCallbackIfIncorrectResponse() {
        
    // Given
        let translationService = TranslationService(session: URLSessionFake(data: FakeResponseData.translationCorrectData, response: FakeResponseData.responseKO, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation { success, translation in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translation)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetTranslationShouldPostSucessCallbackIfNoErrorAndCorrectData() {

    // Given
        let translationService = TranslationService(session: URLSessionFake(data: FakeResponseData.translationCorrectData, response: FakeResponseData.responseOk, error: nil))
        let text: String = "Bonjour"
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translationService.getTranslation { success, translation in
            // Then
            translationService.reset()
            translationService.addTextToTranslate(of: text)
            let translatedText = "Good morning"

            let detectedLanguage = "Français 🇫🇷"
            
            XCTAssertTrue(success)
            XCTAssertNotNil(translation)

            XCTAssertEqual(translatedText, translation!.translatedText)
            XCTAssertEqual(detectedLanguage, translation!.detectedSourceLanguage)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)

    }
    
    

    
    
    

}
