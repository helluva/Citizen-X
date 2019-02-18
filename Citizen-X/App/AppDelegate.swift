//
//  AppDelegate.swift
//  Citizen-X
//
//  Created by Cliff Panos on 2/16/19.
//  Copyright © 2019 Clifford Panos. All rights reserved.
//

import UIKit
import HoundifySDK
import AVFoundation
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        
        // configure the HoundifySDK
        Hound.setClientID("tVd_3zbhwcUeKiPtpMYYNQ==")
        Hound.setClientKey("EuajQg4D6KR1DZmLhGg4vYmbM75JK_P68nJ_6PkSjMx-zbIGNDB4HNq_XGTyLC4wpH-lOiQR6JfNIbSm3fozzw==")
        
        HoundVoiceSearch.instance().enableSpeech = false
        
        // prepare the audio session
        AVAudioSession.sharedInstance().requestRecordPermission { permission in
            guard permission else {
                fatalError("Must grant permission to access microphone.")
            }
            
            do {
                try AVAudioSession.sharedInstance().setCategory(.playAndRecord, mode: .default, options: [])
            } catch {
                fatalError("Could not configure the audio session: \(error)")
            }
        }
        
        return true
    }
    
    private var _notificationToken: Any? = nil
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool
    {
        let components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        if components.host == "query",
            let city = components.queryItems?.first(where: { $0.name == "city" })?.value,
            let queryText = components.queryItems?.first(where: { $0.name == "q" })?.value,
            let queryJsonText = components.queryItems?.first(where: { $0.name == "json" })?.value,
            let queryJson = try? JSONSerialization.jsonObject(with: Data(queryJsonText.utf8), options: []) as? [String: Any]
        {
            CLGeocoder().geocodeAddressString(city, completionHandler: { placemarks, error in
                guard let placemark = placemarks?.first,
                    let coordinates = placemark.location else
                {
                    return
                }
                
                let contentController = ((self.window?.rootViewController as? UINavigationController)?
                    .viewControllers.first as? InteractionStackViewController)?
                    .contentController
                
                contentController?.location = Location(city: city, coordinate: coordinates)
                
                self._notificationToken = NotificationCenter.default.addObserver(
                    forName: .interactionsControllerDidFetchNewLegislators,
                    object: city,
                    queue: .main,
                    using: { _ in
                        contentController?.handleQueryResult(queryJson, for: queryText)
                        
                        if let notificationToken = self._notificationToken {
                            NotificationCenter.default.removeObserver(notificationToken)
                        }
                })
            })
        }
        
        
        
        return true
    }

}

