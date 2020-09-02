//
//  UserController.swift
//  EcoSoapBank
//
//  Created by Jon Bash on 2020-08-20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation
import Combine
import OktaAuth


protocol UserDataProvider {
    func logIn(_ completion: @escaping ResultHandler<User>)
}


class UserController: ObservableObject {
    @Published private(set) var user: User?
    @Published var viewingProperty: Property?

    private var dataLoader: UserDataProvider
    
    private var cancellables: Set<AnyCancellable> = []

    init(dataLoader: UserDataProvider) {
        self.dataLoader = dataLoader

        NotificationCenter.default
            .publisher(for: .oktaAuthenticationSuccessful)
            .sink(receiveValue: loginDidComplete(_:))
            .store(in: &cancellables)
        $user.sink(receiveValue: { [weak self] user in
            self?.viewingProperty = user?.properties?.first
        }).store(in: &cancellables)
    }
}

// MARK: - Public

extension UserController {
    var oktaLoginURL: URL? { OktaAuth.shared.identityAuthURL() }

    func logInWithBearer(completion: @escaping ResultHandler<User>) {
        self.dataLoader.logIn { [weak self] result in
            if case .success(let user) = result {
                self?.user = user
            }
            completion(result)
        }
    }
}

// MARK: - Private

extension UserController {
    private func loginDidComplete(_ notification: Notification) {
        dataLoader.logIn { [weak self] result in
            switch result {
            case .success(let user):
                self?.user = user
            case .failure:
                self?.user = nil
            }
        }
    }
}
