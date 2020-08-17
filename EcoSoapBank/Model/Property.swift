/* GRAPHQL SCHEMA (as of 2020-08-07 15:25)
 type Property {
     id: ID!
     name: String!
     propertyType: PropertyType!
     rooms: Int!
     services: [HospitalityService]!
     collectionType: CollectionType!
     logo: Url
     phone: String
     billingAddress: Address
     shippingAddress: Address
     coordinates: Coordinates
     shippingNote: String
     notes: String
     hub: Hub
     impact: ImpactStats
     users: [User]
     pickups: [Pickup]
     contract: HospitalityContract
 }
 */

import Foundation

struct Property: Decodable {
    internal init(id: Int,
                  name: String,
                  propertyType: String,
                  rooms: Int,
                  services: [String],
                  collectionType: String,
                  logo: String?,
                  phone: String?,
                  shippingNote: String?,
                  notes: String?,
                  impact: ImpactStats?,
                  pickups: [Pickup]?) {
        self.id = id
        self.name = name
        self.propertyType = propertyType
        self.rooms = rooms
        self.services = services
        self.collectionType = collectionType
        self.logo = logo
        self.phone = phone
        self.shippingNote = shippingNote
        self.notes = notes
        self.impact = impact
        self.pickups = pickups
    }
    
    let id: Int
    let name: String
    let propertyType: String//PropertyType.RawValue
    let rooms: Int
    let services: [String]//[HospitalityService.RawValue]
    let collectionType: String//Pickup.CollectionType.RawValue
    let logo: String?
    let phone: String?
    let shippingNote: String?
    let notes: String?
    let impact: ImpactStats?
    let pickups: [Pickup]?

    enum PropertyType: String, Decodable {
        case bedAndBreakfast = "BED_AND_BREAKFAST"
        case guesthouse = "GUESTHOUSE"
        case hotel = "HOTEL"
        case other = "OTHER"
    }

    enum BillingMethod: String, Decodable {
        case ach = "ACH"
        case credit = "CREDIT"
        case debit = "DEBIT"
        case invoice = "INVOICE"
    }
}
