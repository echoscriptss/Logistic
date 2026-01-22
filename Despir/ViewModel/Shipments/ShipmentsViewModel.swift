//
//  ShipmentsViewModel.swift
//  Despir
//
//  Created by Prabhjot Singh on 15/01/26.
//

import Foundation
internal import Combine
import APIManager

class ShipmentsViewModel: ObservableObject {
  
  // MARK: - Variables
  @Published var errorMessage: String?
  @Published var showAlert: Bool = false
  @Published var shipmentData: OrdersResponseModel?
  @Published var filterModel = ShipmentFilterModel()
  @Published var filterResponseModel: ShipmentFilterResponseModel?

  func callGetOrdersApi() async {
    let endPoint =  EndPoint.getOrders(page: filterModel.page, limit: filterModel.limit, isDelivered: filterModel.isDelivered, assignedToMe: filterModel.assignedToMe, sortOrder: filterModel.sortOrder, orderBy: filterModel.orderBy, customer: filterModel.customer, carrier: filterModel.carrier, enteredBy: filterModel.enteredBy, dispatcher: filterModel.dispatcher, pickupStart: filterModel.pickupStart, pickupEnd: filterModel.pickupEnd, deliveryStart: filterModel.deliveryStart, deliveryEnd: filterModel.deliveryEnd, orderType: filterModel.orderType, scheduleEarlyDate: filterModel.scheduleEarlyDate, tsa: filterModel.tsa)
        do {
          shipmentData = try await APIManager.shared.request(url: endPoint.url, methodType: endPoint.httpMethod.rawValue, headers: endPoint.headers, responseType: OrdersResponseModel.self)
          if shipmentData?.statusCode != nil {
            errorMessage = shipmentData?.message
            showAlert = true
          } else {
            
          }
          print(shipmentData ?? "")
        } catch {
            errorMessage = error.localizedDescription
            showAlert = true
        }
    }
  
  
  func callGetFiltersApi() async {
    let endPoint =  EndPoint.getFilterOptions
        do {
          filterResponseModel = try await APIManager.shared.request(url: endPoint.url, methodType: endPoint.httpMethod.rawValue, headers: endPoint.headers, responseType: ShipmentFilterResponseModel.self)
          if filterResponseModel?.statusCode != nil {
            errorMessage = filterResponseModel?.message
            showAlert = true
          } else {
            
          }
          print(filterResponseModel ?? "")
        } catch {
            errorMessage = error.localizedDescription
            showAlert = true
        }
    }
  
}
