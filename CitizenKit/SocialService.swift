//
//  SocialService.swift
//  CitizenKit
//
//  Created by Cliff Panos on 2/16/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import Foundation

public struct SocialService: Codable {
    
    public let provider: Provider
    internal let value: String
    
    public enum Provider: String, Codable {
        case votesmart = "VOTESMART"
        case responsivePolitics = "CRP"
        
        case twitter = "TWITTER"
        case instagram = "INSTAGRAM"
        case facebook = "FACEBOOK-OFFICIAL"
    }
    
    public var isSocialMedia: Bool {
        return provider == .facebook || provider == .instagram || provider == .twitter
    }
    
    public var displayString: String {
        switch provider {
        case .votesmart: return "Vote Smart"
        case .responsivePolitics: return "Responsive Politics"
            
        case .twitter: return "Twitter"
        case .instagram: return "Instagram"
        case .facebook: return "Facebook"
        }
    }
    
    public var websiteURL: URL {
        switch provider {
        case .votesmart:
            return URL(string: "https://votesmart.org/candidate/biography/\(value)/")!
        case .responsivePolitics:
            return URL(string: "https://www.opensecrets.org/members-of-congress/summary?cid=\(value)")!
        case .twitter:
            return URL(string: "https://twitter.com/\(value)")!
        case .instagram:
            return URL(string: "https://www.instagram.com/\(value)/")!
        case .facebook:
            return URL(string: "\(value)")!
        }
        
    }
}
