//
//  PickupsView.swift
//  EcoSoapBank
//
//  Created by Jon Bash on 2020-08-10.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import SwiftUI
import Combine


struct PickupsView: View {
    @ObservedObject private var pickupController: PickupController

    @State private var makingNewPickup = false

    init(pickupController: PickupController) {
        self.pickupController = pickupController
    }

    var body: some View {
        NavigationView {
            PickupHistoryView(pickupController: pickupController)
                .navigationBarTitle("Pickup History", displayMode: .inline)
                .navigationBarItems(trailing: Button(
                    action: newPickup,
                    label: newPickupButton)
            )
        }
    }

    private func newPickupButton() -> some View {
        Image(uiImage: .addBoxSymbol)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .foregroundColor(.white)
            .padding(EdgeInsets(top: 5,
                                leading: 11,
                                bottom: 5,
                                trailing: 9))
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill()
                    .foregroundColor(Color(.link)))
            .frame(height: 36)
            .accessibility(label: Text("Schedule New Pickup"))
    }

    private func gradientBackground() -> some View {
        LinearGradient(
            gradient: Gradient(colors: [Color(.esbGreen), Color(.downyBlue)]),
            startPoint: .top,
            endPoint: .bottom)
            .frame(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height + 160)
    }

    private func presentNewPickupView() -> some View {
        NewPickupViewController.Representable(
            viewModel: pickupController.newPickupViewModel)
    }

    private func newPickup() {
        pickupController.presentNewPickup.send()
    }
}

struct PickupsView_Previews: PreviewProvider {
    static var previews: some View {
        PickupsView(pickupController: PickupController(
            dataProvider: MockPickupProvider()))
    }
}