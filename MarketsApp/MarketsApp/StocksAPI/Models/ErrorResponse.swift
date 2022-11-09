//
//  ErrorResponse.swift
//  
//
//  Created by João Gameiro on 30/10/2022.
//

import Foundation

public struct ErrorResponse: Codable {
    
    public let code: String
    public let description: String
    
    public init(code: String, description: String) {
        self.code = code
        self.description = description
    }
}
