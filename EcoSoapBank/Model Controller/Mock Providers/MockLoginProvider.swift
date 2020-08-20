//
//  MockLoginProvider.swift
//  EcoSoapBank
//
//  Created by Jon Bash on 2020-08-20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation


struct MockLoginProvider: UserDataProvider {
    var shouldFail: Bool

    init(shouldFail: Bool = false) {
        self.shouldFail = shouldFail
    }

    func provideToken(_ token: String) {
        print("token: \(token)")
    }

    func logIn(_ completion: @escaping NetworkCompletion<User>) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            if self.shouldFail {
                completion(.mockFailure())
            } else {
                completion(.success(.placeholder()))
            }
        }
    }
}


extension User {
    static func placeholder() -> User {
        User(
            id: Int.random(in: Int.min ... Int.max),
            firstName: "Bibbly",
            middleName: "Chrumbus",
            lastName: "Boobly",
            title: nil,
            company: "Boobly Inc.",
            email: "Bibbly@Boobly.zone",
            password: "I@m5uper$m@R7",
            phone: "555-123-4444",
            skype: nil,
            properties: [
                Property(
                    id: Int.random(in: Int.min ... Int.max),
                    name: "Boobly Inn",
                    propertyType: Property.PropertyType.hotel.rawValue,
                    rooms: 20,
                    services: HospitalityService.allCases.map { $0.rawValue },
                    collectionType: Pickup.CollectionType.random().rawValue,
                    logo: nil,
                    phone: "555-124-3333",
                    shippingNote: "Blep",
                    notes: "bloop")
        ])
    }
}