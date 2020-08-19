//
//  PickupHistoryView.swift
//  EcoSoapBank
//
//  Created by Jon Bash on 2020-08-07.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import SwiftUI

struct PickupHistoryView: View {
    @ObservedObject var pickupController: PickupController

    init(pickupController: PickupController) {
        self.pickupController = pickupController

        UITableView.appearance().backgroundColor = .clear
    }

    var body: some View {
        List {
            ForEach(pickupController.pickups) {
                PickupHistoryCell(pickup: $0)
            }
        }.listBackgroundColor(color: .esbGreen)
    }
}


// MARK: - Previews

struct PickupHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        PickupHistoryView(
            pickupController: .init(dataProvider: MockPickupProvider()))
    }
}
