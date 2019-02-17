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

}

