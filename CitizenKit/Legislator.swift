//
//  Legislator.swift
//  CitizenKit
//
//  Created by Cal Stephens on 2/16/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import UIKit


// MARK: - Legislator

public class Legislator {
    
    public let name: String
    public let office: Office
    public let party: Party
    public let imageURL: URL
    public let website: URL?
    public let email: String?
    
    public let officeLocation: String
    public let termStart: Date
    public let termEnd: Date?
    
    public var socialServices: [SocialService] = []
    
    
    public enum Party: String {
        case republican = "Republican"
        case democrat = "Democrat"
        case independent = "Independent"
        case unknown = "Unknown"
        
        public var tintColor: UIColor {
            switch self {
            case .republican: return .red
            case .democrat: return .blue
            case .independent: return .green
            case .unknown: return .gray
            }
        }
        
        public var displayString: String {
            switch self {
            case .republican: return "REP"
            case .democrat: return "DEM"
            case .independent: return "IND"
            case .unknown: return "NONE"
            }
        }
    }
    
    public enum Office {
        // national
        case executive(title: String)
        case senator(for: USState)
        case houseRepresentative(for: USState, district: Int)
        
        // state
        case stateExecutive(title: String, of: USState)
        case stateSenator(of: USState, district: Int)
        case stateRepresentative(of: USState, district: Int)
        
        // local
        case localExecutive(title: String, city: String, state: USState)
        
        public enum Level {
            case national
            case state
            case local
        }
        
        public var displayString: String {
            switch self {
            case .executive(let title):
                return "United States \(title)"
                
            case .senator(let state):
                return "US Senator for \(state.rawValue)"
                
            case .houseRepresentative(let state, let district):
                return "US Representative for \(state.abbreviation)-\(district)"
                
            case .stateExecutive(let position, let state):
                return "\(position) of \(state.rawValue)"
                
            case .stateSenator(let state, let district):
                return "\(state.rawValue) Senator for \(state.abbreviation)-\(district)"
                
            case .stateRepresentative(let state, let district):
                return "\(state.rawValue) Representative for \(state.abbreviation)-\(district)"
                
            case .localExecutive(let title, let city, let state):
                return "\(title) of \(city), \(state.abbreviation)"
            }
        }
        
        public var level: Level {
            switch self {
            case .executive, .senator, .houseRepresentative:
                return .national
            case .stateExecutive, .stateSenator, .stateRepresentative:
                return .state
            case .localExecutive:
                return .local
            }
        }
        
    }
    
    public init(name: String, office: Office, party: Party, imageURL: URL, website: URL?, email: String?,
                officeLocation: String, termStart: Date, termEnd: Date?) {
        self.name = name
        self.office = office
        self.party = party
        self.imageURL = imageURL
        self.website = website
        self.email = email
        
        self.officeLocation = officeLocation
        self.termStart = termStart
        self.termEnd = termEnd
    }
    
}
