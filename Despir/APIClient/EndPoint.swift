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

        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login, .verifyMfa, .resendOtpMfa, .forgotPassword, .changePassword , .verifyOTP, .resetPassword, .updateProfile:
            return .POST
        case .getRoles:
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
