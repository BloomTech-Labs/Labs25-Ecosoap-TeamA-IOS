//
//  UtilityTests.swift
//  EcoSoapBankTests
//
//  Created by Jon Bash on 2020-08-07.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//
// swiftlint:disable nesting

import XCTest
import Combine
@testable import EcoSoapBank


class UtilityTests: XCTestCase {

    func testConfigure() {
        class TestObject {
            var int = 0
        }
        
        let int = configure(9) { $0 += 1 }
        XCTAssertEqual(int, 10)

        let object = configure(TestObject()) {
            let x = 30 * 2
            $0.int *= 234
            $0.int = x - 18
        }
        XCTAssertEqual(object.int, 42)
    }

    func testDateConvenienceInit() {
        let date = Date(year: 2020, month: 3, day: 19, hour: 8, minute: 56)
        XCTAssertNotNil(date, "Expected non-nil date from initializer")

        let components = Calendar.current.dateComponents(in: .current, from: date!)
        XCTAssertEqual(components.year, 2020)
        XCTAssertEqual(components.month, 3)
        XCTAssertEqual(components.day, 19)
        XCTAssertEqual(components.hour, 8)
        XCTAssertEqual(components.minute, 56)
    }

    func testPublisherHandleError() {
        var hitSuccess = false
        var hitFailure = false
        var cancellables = Set<AnyCancellable>()

        Just(100)
            .map { String($0) }
            .handleError { _ in XCTFail("Should never reach") }
            .map { $0 + "!" }
            .sink {
                XCTAssertEqual($0, "100!")
                hitSuccess = true
            }.store(in: &cancellables)

        XCTAssert(hitSuccess, "Did not reach success sink")

        Future<Int, TestError> { $0(.failure(TestError.oops)) }
            .handleError { error in
                XCTAssertEqual(error, TestError.oops)
                hitFailure = true
            }.sink { _ in XCTFail("Should never reach") }
            .store(in: &cancellables)

        XCTAssert(hitFailure, "Did not reach failure")
    }
}

enum TestError: Error {
    case oops
}
