//
//  ImpactCellViewModel.swift
//  EcoSoapBank
//
//  Created by Shawn Gee on 8/13/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

struct ImpactCellViewModel {
    let title: String
    let subtitle: String
    let image: UIImage
}

extension ImpactCellViewModel {
    init(withAmount grams: Int,
         convertedTo unit: UnitMass,
         subtitle: String,
         image: UIImage) {
        let weightGrams = Measurement(value: Double(grams), unit: UnitMass.grams)
        self.title = weightGrams.converted(to: unit).string
        self.subtitle = subtitle
        self.image = image
    }
}
