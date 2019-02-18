//
//  CivicInteractionsController.swift
//  Citizen-X
//
//  Created by Cal Stephens on 2/16/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import Foundation
import CitizenKit
import HoundifySDK
import CoreLocation


// MARK: - CivicInteractionsControllerDelegate

protocol CivicInteractionsControllerDelegate: class {
    func addedNewInteraction(_ interaction: CivicInteraction)
    func errorFetchingLegislators(_ error: Error)
}


// MARK: - CivicInteractionsController

class CivicInteractionsController {
    
    weak var delegate: CivicInteractionsControllerDelegate?
    var interactions: [CivicInteraction] = [CivicInteraction(responseContent: GetStartedCardContent.default)]
    
    var location: Location {
        didSet {
            updateLegislators()
        }
    }
    
    private var allLegislators = [Legislator]()
    private let feedbackGenerator = UINotificationFeedbackGenerator()
    
    init(for location: Location) {
        self.location = location
        updateLegislators()
    }
    
    private func updateLegislators() {
        // specifically capture `city` at this moment
        let city = location.city
        
        self.addNewInteraction(CivicInteraction(
            queryText: city,
            shareableUrl: nil,
            responseContent: LocationViewContent(location: location)))
        
        Phone2Action.loadLocalLegislators(for: city).then { legislators in
            self.allLegislators = legislators
            print("Updated legislators for \(city)")
            NotificationCenter.default.post(name: .interactionsControllerDidFetchNewLegislators, object: city)
        }.catch { error in
            print("Error fetching legislators: \(error)")
            self.delegate?.errorFetchingLegislators(error)
        }
    }
    
    private func addNewInteraction(_ interaction: CivicInteraction) {
        interactions.append(interaction)
        delegate?.addedNewInteraction(interaction)
    }
    
    func presentListeningViewController(
        in viewController: UIViewController,
        from view: UIView)
    {
        let style = HoundifyStyle()
        style.backgroundColor = .applicationPrimary
        style.buttonTintColor = .applicationPrimary
        style.ringColor = .white
        style.textColor = .applicationSecondary
        
        HoundVoiceSearch.instance().enableHotPhraseDetection = false
        
        var clientMatchOptions: [[String: Any]] = [
            ["Expression": "Show me my local representatives",
             "Result": ["representatives": "local"],
             "SpokenResponse": "",
             "SpokenResponseLong": "",
             "WrittenResponse": "",
             "WrittenResponseLong": ""],
            
            ["Expression": "Who are my local representatives",
             "Result": ["representatives": "local"],
             "SpokenResponse": "",
             "SpokenResponseLong": "",
             "WrittenResponse": "",
             "WrittenResponseLong": ""],
            
            ["Expression": "Tell me about my local representatives",
             "Result": ["representatives": "local"],
             "SpokenResponse": "",
             "SpokenResponseLong": "",
             "WrittenResponse": "",
             "WrittenResponseLong": ""],
            
            ["Expression": "Show me my state representatives",
             "Result": ["representatives": "state"],
             "SpokenResponse": "",
             "SpokenResponseLong": "",
             "WrittenResponse": "",
             "WrittenResponseLong": ""],
            
            ["Expression": "Who are my state representatives",
             "Result": ["representatives": "state"],
             "SpokenResponse": "",
             "SpokenResponseLong": "",
             "WrittenResponse": "",
             "WrittenResponseLong": ""],
            
            ["Expression": "Tell me about my state representatives",
             "Result": ["representatives": "state"],
             "SpokenResponse": "",
             "SpokenResponseLong": "",
             "WrittenResponse": "",
             "WrittenResponseLong": ""],
            
            ["Expression": "Show me my national representatives",
             "Result": ["representatives": "national"],
             "SpokenResponse": "",
             "SpokenResponseLong": "",
             "WrittenResponse": "",
             "WrittenResponseLong": ""],
            
            ["Expression": "Who are my national representatives",
             "Result": ["representatives": "national"],
             "SpokenResponse": "",
             "SpokenResponseLong": "",
             "WrittenResponse": "",
             "WrittenResponseLong": ""],
            
            ["Expression": "Tell me about my national representatives",
             "Result": ["representatives": "national"],
             "SpokenResponse": "",
             "SpokenResponseLong": "",
             "WrittenResponse": "",
             "WrittenResponseLong": ""],
            
            ["Expression": "Show me my representatives",
             "Result": ["representatives": "all"],
             "SpokenResponse": "",
             "SpokenResponseLong": "",
             "WrittenResponse": "",
             "WrittenResponseLong": ""],
            
            ["Expression": "Who are my representatives",
             "Result": ["representatives": "all"],
             "SpokenResponse": "",
             "SpokenResponseLong": "",
             "WrittenResponse": "",
             "WrittenResponseLong": ""],
            
            ["Expression": "Tell me about my representatives",
             "Result": ["representatives": "all"],
             "SpokenResponse": "",
             "SpokenResponseLong": "",
             "WrittenResponse": "",
             "WrittenResponseLong": ""]]
        
        clientMatchOptions += allLegislators.flatMap { legislator -> [[String: Any]] in
            let legislatorName = legislator.name.folding(options: .diacriticInsensitive, locale: .current)
            
            return [
                ["Expression": "Tell me more about \(legislatorName)",
                 "Result": ["representative": legislatorName],
                 "SpokenResponse": "",
                 "SpokenResponseLong": "",
                 "WrittenResponse": "",
                 "WrittenResponseLong": ""],
                
                ["Expression": "More about \(legislatorName)",
                 "Result": ["representative": legislatorName],
                 "SpokenResponse": "",
                 "SpokenResponseLong": "",
                 "WrittenResponse": "",
                 "WrittenResponseLong": ""],
                
                ["Expression": "Information about \(legislatorName)",
                 "Result": ["representative": legislatorName],
                 "SpokenResponse": "",
                 "SpokenResponseLong": "",
                 "WrittenResponse": "",
                 "WrittenResponseLong": ""],
                
                ["Expression": "Tell me about \(legislatorName)",
                 "Result": ["representative": legislatorName],
                 "SpokenResponse": "",
                 "SpokenResponseLong": "",
                 "WrittenResponse": "",
                 "WrittenResponseLong": ""],
                
                ["Expression": "Teach me about \(legislatorName)",
                 "Result": ["representative": legislatorName],
                 "SpokenResponse": "",
                 "SpokenResponseLong": "",
                 "WrittenResponse": "",
                 "WrittenResponseLong": ""],
            
                ["Expression": "Engage me with \(legislatorName)",
                 "Result": ["representative": legislatorName],
                 "SpokenResponse": "",
                 "SpokenResponseLong": "",
                 "WrittenResponse": "",
                 "WrittenResponseLong": ""],
            ]
        }
        
        Houndify.instance().presentListeningViewController(
            in: viewController,
            from: viewController.view.convert(view.center, to: viewController.view),
            style: style,
            requestInfo: ["ClientMatches": clientMatchOptions],
            responseHandler:
            
            { (error: Error?, response: Any?, dictionary: [String : Any]?, requestInfo: [String : Any]?) in
                
                defer {
                    switch HoundVoiceSearch.instance().state {
                    case .recording:
                        HoundVoiceSearch.instance().stopListening(completionHandler: nil)
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
                            Houndify.instance().dismissListeningViewController(animated: true, completionHandler: nil)
                        })

                    case .none, .ready, .searching, .speaking:
                        Houndify.instance().dismissListeningViewController(animated: true, completionHandler: nil)
                        
                    @unknown default:
                        fatalError()
                    }
                }
                
                guard let dictionary = dictionary,
                    let allResults = dictionary["AllResults"] as? [[String: Any]],
                    let result = allResults.first,
                    let nativeData = result["NativeData"] as? [String: Any] else
                {
                    // TODO: error handling?
                    return
                }
                
                
                // custom commands have spoken query properties
                if let matchedItem = result["MatchedItem"] as? [String: Any],
                    let spokenQuery = matchedItem["Expression"] as? String
                {
                    self.handleQueryResult(nativeData["Result"] as? [String: Any] ?? [:], for: spokenQuery)
                }
                
                else {
                    self.handleQueryResult(nativeData, for: nil)
                }
            })
        
        
    }
    
    func handleQueryResult(_ queryResult: [String: Any], for spokenQuery: String?) {
        print("Handling query: \(String(describing: spokenQuery))")
        
        var responseContent: CardContentProviding? = nil
        var isShareable = true
        
        // "Who are my local/state/national representatives?"
        if let representativesQueryScope = queryResult["representatives"] as? String {
            let representativeLevels: [Legislator.Office.Level]
            
            switch representativesQueryScope {
            case "local":
                representativeLevels = [.local]
            case "state":
                representativeLevels = [.state]
            case "national":
                representativeLevels = [.national]
            case "all":
                representativeLevels = [.local, .state, .national]
            default:
                fatalError("Invalid value.")
            }
            
            responseContent = LegislatorsViewContent(legislators: self.allLegislators.filter {
                representativeLevels.contains($0.office.level)
            })
        }
        
        // "Tell me more about Nancy Pelosi"
        if let representativeNameQuery = queryResult["representative"] as? String {
            let match = self.allLegislators.first(where: {
                representativeNameQuery.lowercased() == $0.name.lowercased().folding(options: .diacriticInsensitive, locale: .current)
            })
            if let singleLegislator = match {
                responseContent = LegislatorsViewContent(legislators: [singleLegislator])
                print("Matched single legislator interaction for \(singleLegislator.name)")
            }
        }
        
        // location lookup: "Show me Miami, FL"
        if let mapLocationSpec = (queryResult["MapLocationSpecs"] as? [[String: Any]])?.first,
            mapLocationSpec["CountryCode"] as? String == "US",
            let city = mapLocationSpec["City"] as? String,
            let state = mapLocationSpec["Admin1"] as? String,
            let longitude = mapLocationSpec["Longitude"] as? Double,
            let latitude = mapLocationSpec["Latitude"] as? Double,
            let usState = USState(rawValue: state)
        {
            let location = Location(
                city: "\(city), \(usState.abbreviation)",
                coordinate: CLLocation(
                    latitude: CLLocationDegrees(latitude),
                    longitude: CLLocationDegrees(longitude)))
            
            self.location = location
            return
        }
        
        if let responseContent = responseContent {
            
            var shareableUrl: URL?
            
            if isShareable {
                var shareableUrlComponents = URLComponents(string: "representative://query")!
                shareableUrlComponents.queryItems = [
                    URLQueryItem(name: "city", value: location.city),
                    URLQueryItem(name: "q", value: spokenQuery),
                    URLQueryItem(name: "json", value: String(
                        data: (try? JSONSerialization.data(withJSONObject: queryResult, options: [])) ?? Data(),
                        encoding: .utf8))]
                shareableUrl = shareableUrlComponents.url
            } else {
                shareableUrl = nil
            }
            
            let responseIsQuestion = spokenQuery?.lowercased().contains("who ") == true
            
            self.feedbackGenerator.notificationOccurred(.success)
            self.addNewInteraction(CivicInteraction(
                queryText: spokenQuery?.replacingOccurrences(of: "\"", with: "").appending(responseIsQuestion ? "?" : ""),
                shareableUrl: shareableUrl,
                responseContent: responseContent))
        } else {
            feedbackGenerator.notificationOccurred(.warning)
        }
    }
    
}


extension Notification.Name {
    
    static let interactionsControllerDidFetchNewLegislators = Notification.Name("interactionsControllerDidFetchNewLegislators")
    
}
