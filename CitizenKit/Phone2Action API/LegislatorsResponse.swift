//
//  LegislatorsResponse.swift
//  CitizenKit
//
//  Created by Cal Stephens on 2/16/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import Foundation

struct LegislatorsResponse: Codable {
    let officials: [OfficialResponse]
}

struct OfficialResponse: Codable {
    let firstName: String
    let lastName: String
    let termStart: Date
    let termEnd: Date
    let party: String
    let photo: String
    let websites: [String]
    let emails: [String]
    let officeDetails: OfficeDetailResponse
}

struct OfficeDetailResponse: Codable {
    let position: String
    let state: String
    let city: String?
}


// MARK: LegislatorsReponse + DecoderProvider

extension LegislatorsResponse: DecoderProvider {
    
    static var preferredDecoder: AnyDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-DD HH:mm:ss"
        
        decoder.dateDecodingStrategy = .formatted(formatter)
        return decoder
    }
    
}
