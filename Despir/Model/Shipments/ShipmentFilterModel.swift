//
//  ShipmentFilterModel.swift
//  Despir
//
//  Created by Prabhjot Singh on 21/01/26.
//

import Foundation

// MARK: - Data Container
struct ShipmentFilterResponseModel: Decodable {
  let success: Bool?
  let message: String?
  let statusCode: Int?
  let customers: [ShipmentFilterCustomersModel]?
  let carriers: [ShipmentFilterCarriersModel]?
  let enteredby: [ShipmentFilterEnteredbyModel]?
  let dispatchers: [ShipmentFilterDispatchersbyModel]?
  let orderTypes: [ShipmentFilterOrderTypesModel]?
  let brokerageStatus: [String]?
}

struct ShipmentFilterCustomersModel: Decodable {
  let id: Int?
  let uuid: String?
  let customerId: String?
  let name: String?
}


struct ShipmentFilterCarriersModel: Decodable {
  let id: Int?
  let uuid: String?
  let legalName: String?
  let name: String?
}

struct ShipmentFilterEnteredbyModel: Decodable {
  let id: Int?
  let uuid: String?
  let firstName: String?
  let lastName: String?
}

struct ShipmentFilterDispatchersbyModel: Decodable {
  let id: Int?
  let uuid: String?
  let firstName: String?
  let lastName: String?
}

struct ShipmentFilterOrderTypesModel: Decodable {
  let orderTypeId: String?
}

