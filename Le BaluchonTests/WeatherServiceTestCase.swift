//
//  WeatherServiceTestCase.swift
//  Le BaluchonTests
//
//  Created by Charlène JERENT-BELDINEAU on 25/06/2023.
//

@testable import Le_Baluchon
import XCTest

class WeatherServiceTestCase: XCTestCase {
    
    //======================
    // MARK: - City name tests
    //======================

    func testGetFirstCityNameShouldPostFailesCallbackIfError() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.cityNameError))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getFirstCityName { success, cityName in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(cityName)
            expectation.fulfill()
        }
//        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetFirstCityNameShouldPostFailesCallbackIfNoData() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getFirstCityName { success, cityName in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(cityName)
            expectation.fulfill()
        }
//        wait(for: [expectation], timeout: 0.01)
        
    }

    func testGetFirstCityNameShouldPostFailesCallbackIfIncorrectResponse() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.cityNameCorrectData, response: FakeResponseData.responseKO, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getFirstCityName { success, cityName in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(cityName)
            expectation.fulfill()
        }
//        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetFirstCityNameShouldPostFailesCallbackIfIncorrectData() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.cityNameIncorrectData, response: FakeResponseData.responseOk, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getFirstCityName { success, cityName in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(cityName)
            expectation.fulfill()
        }
//        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGetFirstCityNameShouldPostSucessCallbackIfNoErrorAndCorrectData() {
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.cityNameCorrectData, response: FakeResponseData.responseOk, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getFirstCityName { success, cityName in
            // Then
            let name = "Paris"
            
            XCTAssertTrue(success)
            XCTAssertNotNil(cityName)

            XCTAssertEqual(name, cityName!.name)

            expectation.fulfill()
        }
//        wait(for: [expectation], timeout: 0.01)

    }
    
    
    //======================
    // MARK: - Temperature tests
    //======================
    
    func testGetFirstCityTemperatureShouldPostFailesCallbackIfError() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.temperatureError))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getFirstCityTemperature { success, temperature in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(temperature)
            expectation.fulfill()
        }
//        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetFirstCityTemperatureShouldPostFailesCallbackIfNoData() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getFirstCityTemperature { success, temperature in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(temperature)
            expectation.fulfill()
        }
//        wait(for: [expectation], timeout: 0.01)
        
    }

    func testGetFirstCityTemperatureShouldPostFailesCallbackIfIncorrectResponse() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.temperatureCorrectData, response: FakeResponseData.responseKO, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getFirstCityTemperature { success, temperature in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(temperature)
            expectation.fulfill()
        }
//        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetFirstCityTemperatureShouldPostFailesCallbackIfIncorrectData() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.temperatureIncorrectData, response: FakeResponseData.responseOk, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getFirstCityTemperature { success, temperature in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(temperature)
            expectation.fulfill()
        }
//        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGetFirstCityTemperatureShouldPostSucessCallbackIfNoErrorAndCorrectData() {
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.temperatureCorrectData, response: FakeResponseData.responseOk, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getFirstCityTemperature { success, temperature in
            // Then
            let temp = 23.96
            XCTAssertTrue(success)
            XCTAssertNotNil(temperature)

            XCTAssertEqual(temp, temperature!.temp)

            expectation.fulfill()
        }
//        wait(for: [expectation], timeout: 0.01)

    }
    
    //======================
    // MARK: - Weather decription tests
    //======================
    
    func testGetFirstCityWeatherDescriptionShouldPostFailesCallbackIfError() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.descriptionError))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getFirstCityWeatherDescription { success, weatherDescription in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherDescription)
            expectation.fulfill()
        }
//        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetFirstCityWeatherDescriptionShouldPostFailesCallbackIfNoData() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getFirstCityWeatherDescription { success, weatherDescription in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherDescription)
            expectation.fulfill()
        }
//        wait(for: [expectation], timeout: 0.01)
        
    }

    func testGetFirstCityWeatherDescriptionShouldPostFailesCallbackIfIncorrectResponse() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.descriptionCorrectData, response: FakeResponseData.responseKO, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getFirstCityWeatherDescription { success, weatherDescription in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherDescription)
            expectation.fulfill()
        }
//        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetFirstCityWeatherDescriptionShouldPostFailesCallbackIfIncorrectData() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.descriptionIncorrectData, response: FakeResponseData.responseOk, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getFirstCityWeatherDescription { success, weatherDescription in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherDescription)
            expectation.fulfill()
        }
//        wait(for: [expectation], timeout: 0.01)
    }
    
    
    func testGetFirstCityWeatherDescriptionShouldPostSucessCallbackIfNoErrorAndCorrectData() {
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.descriptionCorrectData, response: FakeResponseData.responseOk, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getFirstCityWeatherDescription { success, weatherDescription in
            // Then
            let description = "ciel dégagé"
            XCTAssertTrue(success)
            XCTAssertNotNil(weatherDescription)

            XCTAssertEqual(description, weatherDescription!.description)

            expectation.fulfill()
        }
//        wait(for: [expectation], timeout: 0.01)

    }
    
    //======================
    // MARK: - Icon tests
    //======================
    
    func testGetFirstCityWeatherIconShouldPostFailesCallbackIfError() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.iconError))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getFirstCityWeatherIcon { success, weatherIcon in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherIcon)
            expectation.fulfill()
        }
//        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetFirstCityWeatherIconShouldPostFailesCallbackIfNoData() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getFirstCityWeatherIcon { success, weatherIcon in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherIcon)
            expectation.fulfill()
        }
//        wait(for: [expectation], timeout: 0.01)
        
    }

    func testGetFirstCityWeatherIconShouldPostFailesCallbackIfIncorrectResponse() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.iconCorrectData, response: FakeResponseData.responseKO, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getFirstCityWeatherIcon { success, weatherIcon in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherIcon)
            expectation.fulfill()
        }
//        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetFirstCityWeatherIconShouldPostFailesCallbackIfIncorrectData() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.iconIncorrectData, response: FakeResponseData.responseOk, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getFirstCityWeatherIcon { success, weatherIcon in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherIcon)
            expectation.fulfill()
        }
//        wait(for: [expectation], timeout: 0.01)
    }
    
    
//    func testGetFirstCityWeatherIconShouldPostSucessCallbackIfNoErrorAndCorrectData() {
//    // Given
//        let weatherService = WeatherService(session: URLSessionFake(data:FakeResponseData.iconCorrectData , response: FakeResponseData.responseOk, error: nil))
//    // When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        weatherService.getFirstCityWeatherIcon { success, weatherIcon in
//            // Then
//            let iconString = "01d"
//            
//            XCTAssertTrue(success)
//            XCTAssertNotNil(weatherIcon)
//
//            XCTAssertEqual(iconString, weatherIcon.)
//
//            expectation.fulfill()
//        }
////        wait(for: [expectation], timeout: 0.01)
//
//    }

}
