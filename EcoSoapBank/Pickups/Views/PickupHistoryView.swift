//
//  PickupHistoryView.swift
//  EcoSoapBank
//
//  Created by Jon Bash on 2020-08-07.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import SwiftUI
import Combine
import SwiftUIRefresh


struct PickupHistoryView: View {
    @ObservedObject var pickupController: PickupController

    @State private var makingNewPickup = false
    @State private var statusWidth: CGFloat?
    @State private var refreshing = false

    @State private var error: Error?

    @State private var fetchSubscription: AnyCancellable?

    private var schedulePickup: () -> Void
    private var goToPickupDetail: (Pickup) -> Void

    init(pickupController: PickupController,
         goToPickupDetail: @escaping (Pickup) -> Void,
         schedulePickup: @escaping () -> Void
    ) {
        self.pickupController = pickupController
        self.goToPickupDetail = goToPickupDetail
        self.schedulePickup = schedulePickup
    }

    var body: some View {
        List {
            ForEach(pickupController.pickups) { pickup in
                PickupHistoryCell(
                    pickup: pickup,
                    statusWidth: self.$statusWidth,
                    goToPickupDetail: self.goToPickupDetail)
            }
        }
        .pullToRefresh(isShowing: $refreshing, onRefresh: refreshPickups)
        .errorAlert($error)
        .navigationBarTitle("Pickup History", displayMode: .inline)
        .listStyle(PlainListStyle())
    }

    private func newPickupButton() -> some View {
        Image(uiImage: .addBoxSymbol)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(height: 28)
            .foregroundColor(.barButtonTintColor)
            .accessibility(label: Text("Schedule New Pickup"))
    }

    private func refreshPickups() {
        self.fetchSubscription = self.pickupController.fetchPickupsForSelectedProperty()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.error = error
                }
                self.refreshing = false
            }, receiveValue: { _ in })
    }
}

// MARK: - Previews

struct PickupHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        PickupHistoryView(
            pickupController: PickupController(
                user: .placeholder(),
                dataProvider: MockPickupProvider()),
            goToPickupDetail: { _ in },
            schedulePickup: {})
    }
}
