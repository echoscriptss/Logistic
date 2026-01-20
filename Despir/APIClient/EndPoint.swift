//
//  EndPoint.swift
//  Despir
//
//  Created by Prabhjot Singh on 22/12/25.
//

import Foundation

enum EndPoint: Equatable {
    case login
    case verifyMfa
    case resendOtpMfa
    case forgotPassword
    case verifyOTP
    case resetPassword
    case getRoles // Temp for get par in httpmethod
    case changePassword
    case updateProfile
    case getOrders(page: Int, limit: Int,  isDelivered: Bool, assignedToMe: Bool, sortOrder: String, orderBy: String, customer: String, carrier: String, enteredBy: String, dispatcher: String, pickupStart: String, pickupEnd: String, deliveryStart: String, deliveryEnd: String, orderType: String, scheduleEarlyDate: String, tsa: Bool)

    
    var endpoint: String {
        switch self {
        case .login:
            return "/auth/login"
        case .verifyMfa:
            return "/auth/verify-mfa"
        case .resendOtpMfa:
            return "/auth/resend-otp"
        case .forgotPassword:
            return "/user/forgot_password"
        case .verifyOTP:
            return "/user/validate_pw_otp"
        case .getRoles:
            return "/user/all_roles"
        case .changePassword:
            return "/user/change_password"
        case .resetPassword:
            return "/user/reset_password"
        case .updateProfile:
          return "/user/update/\(DataManager.userUuid ?? "")"
        case .getOrders(page: let page, limit: let limit, isDelivered: let is_delivered, assignedToMe: let assigned_to_me, sortOrder: let sortOrder, orderBy: let orderby, customer: let customer, carrier: let carrier, enteredBy: let enteredby, dispatcher: let dispatcher, pickupStart: let pickup_start, pickupEnd: let pickup_end, deliveryStart: let delivery_start, deliveryEnd: let delivery_end, orderType: let ordertype, scheduleEarlyDate: let schedule_early_date, tsa: let tsa):
          return "/orders/get_orders?page=\(page)&limit=\(limit)&is_delivered=\(is_delivered)&assigned_to_me=\(assigned_to_me)&sort_order=\(sortOrder)&orderby=\(orderby)&customer=\(customer)&carrier=\(carrier)&enteredby=\(enteredby)&dispatcher=\(dispatcher)&pickup_start=\(pickup_start)&pickup_end=\(pickup_end)&delivery_start=\(delivery_start)&delivery_end=\(delivery_end)&ordertype=\(ordertype)&schedule_early_date=\(schedule_early_date)&tsa=\(tsa)"
          
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login, .verifyMfa, .resendOtpMfa, .forgotPassword, .changePassword , .verifyOTP, .resetPassword, .updateProfile:
            return .POST
        case .getRoles, .getOrders(page: _, limit: _, isDelivered: _, assignedToMe: _, sortOrder: _, orderBy: _, customer: _, carrier: _,enteredBy: _, dispatcher: _, pickupStart: _, pickupEnd: _, deliveryStart: _, deliveryEnd: _ ,orderType: _, scheduleEarlyDate: _, tsa: _):
            return .GET
        }
    }
    
    var route: String {
        let baseURL = DefaultStore.load()?.rawValue ?? UserType.Dev.rawValue //DEV URL
        return baseURL + endpoint
    }
    
    var url: URL? {
        guard let url = URL(string: route) else {
            return nil
        }
        return url
    }

    var headers: [String:String] {
      return ["Authorization":"Bearer \(DataManager.userToken ?? "")"]
    }

}

enum UserType: String, CaseIterable {
    case Dev = "https://eyeonitbackend-gybfe4hvc9djerbe.centralus-01.azurewebsites.net"
    case UAT = "https://eye-on-it-uat-asargaf4b7cqeaf2.centralus-01.azurewebsites.net"
//    case Prod = "https://eyeonit-production-a7g9cmd2deasf2e6.centralus-01.azurewebsites.net"
    case Prod = ""
}

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}
