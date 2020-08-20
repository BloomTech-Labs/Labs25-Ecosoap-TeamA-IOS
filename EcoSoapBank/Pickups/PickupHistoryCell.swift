//
//  PickupListItem.swift
//  EcoSoapBank
//
//  Created by Jon Bash on 2020-08-07.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import SwiftUI
import UIKit


// MARK: - Cell

struct PickupHistoryCell: View {
    let pickup: Pickup

    init(pickup: Pickup) {
        self.pickup = pickup
    }

    var body: some View {
        NavigationLink(destination: PickupDetailView(pickup: pickup)) {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    TitledSegment("Ready") {
                        Text(pickup.readyDate.string(from: Self.dateFormatter))
                    }

                    TitledSegment("Status") {
                        Text("\(pickup.status.display)")
                            .foregroundColor(pickup.status.color)
                        if pickup.pickupDate != nil {
                            Text("(\(pickup.pickupDate!.string(from: Self.dateFormatter)))")
                        }
                    }

                    TitledSegment("Cartons") {
                        Text("\(pickup.cartons.count)")
                    }
                }

                Spacer()

                if !pickup.notes.isEmpty {
                    Image.notes()
                        .foregroundColor(Color(.secondaryLabel))
                }
            }
        }
        .font(Font(UIFont.muli(style: .body)))
    }
}

extension PickupHistoryCell {
    static let dateFormatter = configure(DateFormatter()) {
        $0.dateStyle = .short
        $0.timeStyle = .none
    }

    struct TitledSegment<Content: View>: View {
        let title: String
        let content: Content

        init(_ title: String, @ViewBuilder _ content: () -> Content) {
            self.title = title
            self.content = content()
        }

        var body: some View {
            HStack {
                Text(title + ":").bold()
                content
            }
        }
    }
}


// MARK: - Previews

private let _previewPickup = Pickup.random()

struct PickupListItem_Previews: PreviewProvider {
    static var previews: some View {
        PickupHistoryCell(pickup: _previewPickup)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

struct PickupDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PickupDetailView(pickup: _previewPickup)
    }
}