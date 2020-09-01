//
//  MainProfileViewModel.swift
//  EcoSoapBank
//
//  Created by Jon Bash on 2020-08-31.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import Foundation
import Combine


class MainProfileViewModel: ObservableObject {
    @Published var user: User
    @Published var properties: [Property]
    @Published var selectedPropertyIndex: Int
    let userController: UserController

    var selectedProperty: Property { properties[selectedPropertyIndex] }

    private var cancellables = Set<AnyCancellable>()
    
    init(user: User, currentProperty: Property, userController: UserController) {
        self.user = user
        self.properties = user.properties ?? []
        self.selectedPropertyIndex = 0
        self.userController = userController
    }
}
