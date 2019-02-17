//
//  ContentController.swift
//  Citizen-X
//
//  Created by Cal Stephens on 2/16/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import Foundation
import CitizenKit
import HoundifySDK


// MARK: - ContentControllerDelegate

protocol ContentControllerDelegate: class {
    func addedNewInteraction(_ interaction: Interaction)
}


// MARK: - ContentController

class ContentController {
    
    weak var delegate: ContentControllerDelegate?
    var interactions: [Interaction] = []
    
    var location: String {
        didSet {
            updateLegislators()
        }
    }
    
    private var allLegislators = [Legislator]()
    
    init(for location: String) {
        self.location = location
        updateLegislators()
    }
    
    private func updateLegislators() {
        Phone2Action.fetchLegislators(for: location).then { legislators in
            self.allLegislators = legislators
        }.catch { error in
            print("Error fetching legislators: \(error)")
        }
    }
    
    private func addNewInteraction(_ interaction: Interaction) {
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
        
        Houndify.instance().presentListeningViewController(
            in: viewController,
            from: viewController.view,
            style: style,
            requestInfo: [:],
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
                
                var responseContent: CardContentProviding? = nil
                
                //
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
                    
                    responseContent = LegislatorViewContent(legislators: self.allLegislators.filter {
                        representativeLevels.contains($0.office.level)
                    })
                }
                
                
                if let responseContent = responseContent {
                    self.addNewInteraction(Interaction(
                        queryText: spokenQuery,
                        responseContent: responseContent))
                }
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
    
}
