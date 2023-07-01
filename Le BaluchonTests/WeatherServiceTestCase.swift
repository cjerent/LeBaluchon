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

    //First City
    func testGetFirstCityNameShouldPostFailedCallbackIfError() {
        
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
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetFirstCityNameShouldPostFailedCallbackIfNoData() {
        
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
        wait(for: [expectation], timeout: 0.01)
        
    }

    func testGetFirstCityNameShouldPostFailedCallbackIfIncorrectResponse() {
        
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
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    
    func testGetFirstCityNameShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
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
        wait(for: [expectation], timeout: 0.01)

    }
    
    // Second City
    
    func testGetgetSecondCityNameNameShouldPostFailedCallbackIfError() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.cityNameError))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getSecondCityName { success, cityName in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(cityName)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetSecondCityNameNameShouldPostFailedCallbackIfNoData() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getSecondCityName { success, cityName in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(cityName)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }

    func testGetSecondCityNameNameShouldPostFailedCallbackIfIncorrectResponse() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.cityNameCorrectData, response: FakeResponseData.responseKO, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getSecondCityName { success, cityName in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(cityName)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    
    
    func testGetSecondCityNameNameShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.cityNameCorrectData, response: FakeResponseData.responseOk, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getSecondCityName { success, cityName in
            // Then
            let name = "Paris"
            
            XCTAssertTrue(success)
            XCTAssertNotNil(cityName)

            XCTAssertEqual(name, cityName!.name)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)

    }
    
    
    //======================
    // MARK: - Temperature tests
    //======================
    
    func testGetFirstCityTemperatureShouldPostFailedCallbackIfError() {
        
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
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetFirstCityTemperatureShouldPostFailedCallbackIfNoData() {
        
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
        wait(for: [expectation], timeout: 0.01)
        
    }

    func testGetFirstCityTemperatureShouldPostFailedCallbackIfIncorrectResponse() {
        
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
        wait(for: [expectation], timeout: 0.01)
        
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
        wait(for: [expectation], timeout: 0.01)

    }
    
    func testGetSecondCityTemperatureShouldPostFailedCallbackIfError() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.temperatureError))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getSecondCityTemperature { success, temperature in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(temperature)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetSecondCityTemperatureShouldPostFailedCallbackIfNoData() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getSecondCityTemperature { success, temperature in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(temperature)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }

    func testGetSecondCityTemperatureShouldPostFailedCallbackIfIncorrectResponse() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.temperatureCorrectData, response: FakeResponseData.responseKO, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getSecondCityTemperature { success, temperature in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(temperature)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
        
    }

    
    func testGetSecondCityTemperatureShouldPostSucessCallbackIfNoErrorAndCorrectData() {
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.temperatureCorrectData, response: FakeResponseData.responseOk, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getSecondCityTemperature { success, temperature in
            // Then
            let temp = 23.96
            XCTAssertTrue(success)
            XCTAssertNotNil(temperature)

            XCTAssertEqual(temp, temperature!.temp)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)

    }
    
    //======================
    // MARK: - Weather decription tests
    //======================
    
    func testGetFirstCityWeatherDescriptionShouldPostFailedCallbackIfError() {
        
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
        wait(for: [expectation], timeout: 0.01)
        
    }
    
    func testGetFirstCityWeatherDescriptionShouldPostFailedCallbackIfNoData() {
        
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
        wait(for: [expectation], timeout: 0.01)
        
    }

    func testGetFirstCityWeatherDescriptionShouldPostFailedCallbackIfIncorrectResponse() {
        
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
        wait(for: [expectation], timeout: 0.01)
        
    }
    
//    func testGetFirstCityWeatherDescriptionShouldPostFailedCallbackIfIncorrectData() {
//
//    // Given
//        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.descriptionIncorrectData, response: FakeResponseData.responseOk, error: nil))
//    // When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        weatherService.getFirstCityWeatherDescription { success, weatherDescription in
//            // Then
//            XCTAssertFalse(success)
//            XCTAssertNil(weatherDescription)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.1)
//    }
    
    
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
        wait(for: [expectation], timeout: 0.01)

    }
    
    func testGetSecondCityWeatherDescriptionShouldPostFailedCallbackIfError() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.descriptionError))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getSecondCityWeatherDescription { success, weatherDescription in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherDescription)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
        
    }
    
    func testGetSecondCityWeatherDescriptionShouldPostFailedCallbackIfNoData() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getSecondCityWeatherDescription { success, weatherDescription in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherDescription)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
        
    }

    func testGetSecondCityWeatherDescriptionShouldPostFailedCallbackIfIncorrectResponse() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.descriptionCorrectData, response: FakeResponseData.responseKO, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getSecondCityWeatherDescription { success, weatherDescription in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherDescription)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
        
    }
    
    
    func testGetSecondCityWeatherDescriptionShouldPostSucessCallbackIfNoErrorAndCorrectData() {
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.descriptionCorrectData, response: FakeResponseData.responseOk, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getSecondCityWeatherDescription { success, weatherDescription in
            // Then
            let description = "ciel dégagé"
            XCTAssertTrue(success)
            XCTAssertNotNil(weatherDescription)

            XCTAssertEqual(description, weatherDescription!.description)

            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)

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
        wait(for: [expectation], timeout: 0.1)
        
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
        wait(for: [expectation], timeout: 0.1)
        
    }

    func testGetFirstCityWeatherIconShouldPostFailedCallbackIfIncorrectResponse() {
        
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
        wait(for: [expectation], timeout: 0.1)
        
    }
    
//    func testGetFirstCityWeatherIconShouldPostFailedCallbackIfIncorrectData() {
//    // Given
//        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.iconIncorrectData, response: FakeResponseData.responseOk, error: nil))
//    // When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        weatherService.getFirstCityWeatherIcon { success, weatherIcon in
//            // Then
//            XCTAssertFalse(success)
//            XCTAssertNil(weatherIcon)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.1)
//    }
    
    
    func testGetFirstCityWeatherIconShouldPostSucessCallbackIfNoErrorAndCorrectData() {
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data:FakeResponseData.iconCorrectData, response: FakeResponseData.responseOk, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getFirstCityWeatherIcon { success, weatherIcon in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(weatherIcon)
            
            expectation.fulfill()
            XCTAssertEqual(FakeResponseData.iconCorrectData, weatherIcon)
        }
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testGetSecondCityWeatherIconShouldPostFailesCallbackIfError() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.iconError))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getSecondCityWeatherIcon { success, weatherIcon in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherIcon)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
        
    }
    
    func testGetSecondCityWeatherIconShouldPostFailesCallbackIfNoData() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: nil, response: nil, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getSecondCityWeatherIcon { success, weatherIcon in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherIcon)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
        
    }

    func testGetSecondCityWeatherIconShouldPostFailedCallbackIfIncorrectResponse() {
        
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.iconCorrectData, response: FakeResponseData.responseKO, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getSecondCityWeatherIcon { success, weatherIcon in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weatherIcon)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
        
    }
    
//    func testGetFirstCityWeatherIconShouldPostFailedCallbackIfIncorrectData() {
//    // Given
//        let weatherService = WeatherService(session: URLSessionFake(data: FakeResponseData.iconIncorrectData, response: FakeResponseData.responseOk, error: nil))
//    // When
//        let expectation = XCTestExpectation(description: "Wait for queue change.")
//        weatherService.getFirstCityWeatherIcon { success, weatherIcon in
//            // Then
//            XCTAssertFalse(success)
//            XCTAssertNil(weatherIcon)
//            expectation.fulfill()
//        }
//        wait(for: [expectation], timeout: 0.1)
//    }
    
    
    func testGetSecondCityWeatherIconShouldPostSucessCallbackIfNoErrorAndCorrectData() {
    // Given
        let weatherService = WeatherService(session: URLSessionFake(data:FakeResponseData.iconCorrectData, response: FakeResponseData.responseOk, error: nil))
    // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getSecondCityWeatherIcon { success, weatherIcon in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(weatherIcon)
            
            expectation.fulfill()
            XCTAssertEqual(FakeResponseData.iconCorrectData, weatherIcon)
        }
        wait(for: [expectation], timeout: 0.1)
    }

}
