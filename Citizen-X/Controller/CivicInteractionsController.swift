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


// MARK: - CivicInteractionsControllerDelegate

protocol CivicInteractionsControllerDelegate: class {
    func addedNewInteraction(_ interaction: CivicInteraction)
    func errorFetchingLegislators(_ error: Error)
}


// MARK: - CivicInteractionsController

class CivicInteractionsController {
    
    weak var delegate: CivicInteractionsControllerDelegate?
    var interactions: [CivicInteraction] = []
    
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
        
        Phone2Action.fetchLegislators(for: city).then { legislators in
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
    
    func presentListeningViewController(in viewController: UIViewController) {
        let style = HoundifyStyle()
        style.backgroundColor = .applicationPrimary
        style.buttonTintColor = .applicationPrimary
        style.ringColor = .white
        style.textColor = .applicationSecondary
        
        HoundVoiceSearch.instance().enableHotPhraseDetection = false
        
        let clientMatchOptions: [[String: Any]] = allLegislators.flatMap { legislator in
            return [
                ["Expression": "Tell me more about \(legislator.name)",
                 "Result": ["representative": legislator.name],
                "SpokenResponse": "",
                "SpokenResponseLong": "",
                "WrittenResponse": "",
                "WrittenResponseLong": ""],
                
                ["Expression": "More about \(legislator.name)",
                    "Result": ["representative": legislator.name],
                    "SpokenResponse": "",
                    "SpokenResponseLong": "",
                    "WrittenResponse": "",
                    "WrittenResponseLong": ""],
                
                ["Expression": "Information about \(legislator.name)",
                    "Result": ["representative": legislator.name],
                    "SpokenResponse": "",
                    "SpokenResponseLong": "",
                    "WrittenResponse": "",
                    "WrittenResponseLong": ""],
                
                ["Expression": "Tell me about \(legislator.name)",
                 "Result": ["representative": legislator.name],
                 "SpokenResponse": "",
                 "SpokenResponseLong": "",
                 "WrittenResponse": "",
                 "WrittenResponseLong": ""],
                
                ["Expression": "Teach me about \(legislator.name)",
                    "Result": ["representative": legislator.name],
                    "SpokenResponse": "",
                    "SpokenResponseLong": "",
                    "WrittenResponse": "",
                    "WrittenResponseLong": ""],
            
                ["Expression": "Engage me with \(legislator.name)",
                    "Result": ["representative": legislator.name],
                    "SpokenResponse": "",
                    "SpokenResponseLong": "",
                    "WrittenResponse": "",
                    "WrittenResponseLong": ""],
            ]
            
        }
        
        Houndify.instance().presentListeningViewController(
            in: viewController,
            from: viewController.view,
            style: style,
            requestInfo: ["ClientMatches": clientMatchOptions],
            responseHandler:
            
            { (error: Error?, response: Any?, dictionary: [String : Any]?, requestInfo: [String : Any]?) in
                
                defer {
                    Houndify.instance().dismissListeningViewController(animated: true, completionHandler: nil)
                }
                
                guard let dictionary = dictionary,
                    let allResults = dictionary["AllResults"] as? [[String: Any]],
                    let result = allResults.first,
                    let matchedItem = result["MatchedItem"] as? [String: Any],
                    let spokenQuery = matchedItem["Expression"] as? String,
                    let nativeData = result["NativeData"] as? [String: Any],
                    let queryResult = nativeData["Result"] as? [String: Any] else
                {
                    // TODO: error handling?
                    return
                }
                
                self.handleQueryResult(queryResult, for: spokenQuery)
            })
        
        /*DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
         
         // delicious
         let buttonImageView = self
         .children[0].view.subviews[0].subviews[0]
         .subviews[2].subviews[6].subviews[0].subviews[0]
         as! UIImageView
         
         buttonImageView.layer.filters = [CIFilter(name: "CIPhotoEffectNoir") ]
         }*/
    }
    
    func handleQueryResult(_ queryResult: [String: Any], for spokenQuery: String) {
        print("Handling query: \(spokenQuery)")
        
        var responseContent: CardContentProviding? = nil
        var responseIsQuestion = true
        
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
                $0.name.lowercased() == representativeNameQuery.lowercased()
            })
            if let singleLegislator = match {
                responseContent = LegislatorsViewContent(legislators: [singleLegislator])
                responseIsQuestion = false
                print("Matched single legislator interaction for \(singleLegislator.name)")
            }
        }
        
        
        if let responseContent = responseContent {
            var shareableUrlComponents = URLComponents(string: "representative://query")!
            shareableUrlComponents.queryItems = [
                URLQueryItem(name: "city", value: location.city),
                URLQueryItem(name: "q", value: spokenQuery),
                URLQueryItem(name: "json", value: String(
                    data: (try? JSONSerialization.data(withJSONObject: queryResult, options: [])) ?? Data(),
                    encoding: .utf8))]
            
            self.feedbackGenerator.notificationOccurred(.success)
            self.addNewInteraction(CivicInteraction(
                queryText: spokenQuery.replacingOccurrences(of: "\"", with: "") + (responseIsQuestion ? "?" : ""),
                shareableUrl: shareableUrlComponents.url,
                responseContent: responseContent))
        } else {
            feedbackGenerator.notificationOccurred(.warning)
        }
    }
    
}


extension Notification.Name {
    
    static let interactionsControllerDidFetchNewLegislators = Notification.Name("interactionsControllerDidFetchNewLegislators")
    
}
