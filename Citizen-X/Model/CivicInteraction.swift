//
//  CivicInteraction.swift
//  Citizen-X
//
//  Created by Cal Stephens on 2/16/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import Foundation

class CivicInteraction {
    
    let queryText: String?
    let shareableUrl: URL?
    let responseContent: CardContentProviding
    
    init(
        queryText: String? = nil,
        shareableUrl: URL? = nil,
        responseContent: CardContentProviding)
    {
        self.queryText = queryText
        self.shareableUrl = shareableUrl
        self.responseContent = responseContent
    }
    
}
