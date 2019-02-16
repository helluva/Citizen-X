//
//  State.swift
//  CitizenKit
//
//  Created by Cal Stephens on 2/16/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import Foundation

/// 🇺🇸
public enum USState: String {
    case alabama = "Alabama"
    case alaska = "Alaska"
    case arizona = "Arizona"
    case arkansas = "Arkansas"
    case california = "California"
    case colorado = "Colorado"
    case connecticut = "Connecticut"
    case delaware = "Delaware"
    case districtOfColumbia = "District Of Columbia"
    case florida = "Florida"
    case georgia = "Georgia"
    case hawaii = "Hawaii"
    case idaho = "Idaho"
    case illinois = "Illinois"
    case indiana = "Indiana"
    case iowa = "Iowa"
    case kansas = "Kansas"
    case kentucky = "Kentucky"
    case louisiana = "Louisiana"
    case maine = "Maine"
    case maryland = "Maryland"
    case massachusetts = "Massachusetts"
    case michigan = "Michigan"
    case minnesota = "Minnesota"
    case mississippi = "Mississippi"
    case missouri = "Missouri"
    case montana = "Montana"
    case nebraska = "Nebraska"
    case nevada = "Nevada"
    case newHampshire = "New Hampshire"
    case newJersey = "New Jersey"
    case newMexico = "New Mexico"
    case newYork = "New York"
    case northCarolina = "North Carolina"
    case northDakota = "North Dakota"
    case ohio = "Ohio"
    case oklahoma = "Oklahoma"
    case oregon = "Oregon"
    case pennsylvania = "Pennsylvania"
    case rhodeIsland = "Rhode Island"
    case southCarolina = "South Carolina"
    case southDakota = "South Dakota"
    case tennessee = "Tennessee"
    case texas = "Texas"
    case utah = "Utah"
    case vermont = "Vermont"
    case virginia = "Virginia"
    case washington = "Washington"
    case westVirginia = "West Virginia"
    case wisconsin = "Wisconsin"
    case wyoming = "Wyoming"
    case unknown = "Unknown"
    
    public static func from(_ abbreviation: String) -> USState {
        switch abbreviation {
            case "AL": return .alabama
            case "AK": return .alaska
            case "AZ": return .arizona
            case "AR": return .arkansas
            case "CA": return .california
            case "CO": return .colorado
            case "CT": return .connecticut
            case "DE": return .delaware
            case "DC": return .districtOfColumbia
            case "FL": return .florida
            case "GA": return .georgia
            case "HI": return .hawaii
            case "ID": return .idaho
            case "IL": return .illinois
            case "IN": return .indiana
            case "IA": return .iowa
            case "KS": return .kansas
            case "KY": return .kentucky
            case "LA": return .louisiana
            case "ME": return .maine
            case "MD": return .maryland
            case "MA": return .massachusetts
            case "MI": return .michigan
            case "MN": return .minnesota
            case "MS": return .mississippi
            case "MO": return .missouri
            case "MT": return .montana
            case "NE": return .nebraska
            case "NV": return .nevada
            case "NH": return .newHampshire
            case "NJ": return .newJersey
            case "NM": return .newMexico
            case "NY": return .newYork
            case "NC": return .northCarolina
            case "ND": return .northDakota
            case "OH": return .ohio
            case "OK": return .oklahoma
            case "OR": return .oregon
            case "PA": return .pennsylvania
            case "RI": return .rhodeIsland
            case "SC": return .southCarolina
            case "SD": return .southDakota
            case "TN": return .tennessee
            case "TX": return .texas
            case "UT": return .utah
            case "VT": return .vermont
            case "VA": return .virginia
            case "WA": return .washington
            case "WV": return .westVirginia
            case "WI": return .wisconsin
            case "WY": return .wyoming
            default: return .unknown
        }
    }
    
    public var abbreviation: String {
        switch self {
        case .alabama: return "AL"
        case .alaska: return "AK"
        case .arizona: return "AZ"
        case .arkansas: return "AR"
        case .california: return "CA"
        case .colorado: return "CO"
        case .connecticut: return "CT"
        case .delaware: return "DE"
        case .districtOfColumbia: return "DC"
        case .florida: return "FL"
        case .georgia: return "GA"
        case .hawaii: return "HI"
        case .idaho: return "ID"
        case .illinois: return "IL"
        case .indiana: return "IN"
        case .iowa: return "IA"
        case .kansas: return "KS"
        case .kentucky: return "KY"
        case .louisiana: return "LA"
        case .maine: return "ME"
        case .maryland: return "MD"
        case .massachusetts: return "MA"
        case .michigan: return "MI"
        case .minnesota: return "MN"
        case .mississippi: return "MS"
        case .missouri: return "MO"
        case .montana: return "MT"
        case .nebraska: return "NE"
        case .nevada: return "NV"
        case .newHampshire: return "NH"
        case .newJersey: return "NJ"
        case .newMexico: return "NM"
        case .newYork: return "NY"
        case .northCarolina: return "NC"
        case .northDakota: return "ND"
        case .ohio: return "OH"
        case .oklahoma: return "OK"
        case .oregon: return "OR"
        case .pennsylvania: return "PA"
        case .rhodeIsland: return "RI"
        case .southCarolina: return "SC"
        case .southDakota: return "SD"
        case .tennessee: return "TN"
        case .texas: return "TX"
        case .utah: return "UT"
        case .vermont: return "VT"
        case .virginia: return "VA"
        case .washington: return "WA"
        case .westVirginia: return "WV"
        case .wisconsin: return "WI"
        case .wyoming: return "WY"
        case .unknown: return "--"
        }
    }
    
}
