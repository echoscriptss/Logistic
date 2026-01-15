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
  
  
  func callGetOrdersApi() async {
    let endPoint =  EndPoint.getOrders(page: 1, limit: 25, isDelivered: true, assignedToMe: false, sortOrder: "desc", orderBy: "orderId")
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
  
}
