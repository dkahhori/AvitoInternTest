//
//  DataModel.swift
//  AvitoInternTest
//
//  Created by Dilshodi Kahori on 27/10/22.
//

import Foundation

struct Organization: Decodable {
    let company: Company
    
    struct Company: Decodable {
        let name: String
        let employees: [Employee]
    }
    
    struct Employee: Decodable {
        let name, phoneNumber: String
        let skills: [String]
        
        enum CodingKeys: String, CodingKey {
            case name
            case phoneNumber = "phone_number"
            case skills
        }
    }
}
