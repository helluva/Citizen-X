//
//  Hound.h
//  HoundSDK
//
//  Created by Cyril Austin on 5/20/15.
//  Copyright (c) 2015 SoundHound, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HoundSDKServerDataModels.h"

#pragma mark - Hound

typedef NS_ENUM(NSUInteger, HoundLoggingOption) {
	
	HoundLoggingOptionNone = 0, //Default
    HoundLoggingOptionSpeexArchive = 1 << 0, //Saves the speex archive to the default path, identical to what is streamed during a voice search.
    HoundLoggingOptionAudioChain = 1 << 1, //Logs the data flowing from the microphone to the file streamer
	/*	
		Use this option to log property values associated with the shared AVAudioSession.
		If this is set to YES, the audio session state will be logged when the property is set,
		just before listening begins for the voice search, and again once a response is recieved.
	*/
	HoundLoggingOptionAudioSession = 1 << 2,
};

NS_ASSUME_NONNULL_BEGIN
@interface Hound : NSObject

/**
 Returns the current version of the SDK. Used for debugging.
 */
+ (NSString*)SDKVersion;

/**
 @important This value must be set prior to using the SDK.
 @param clientID The clientID provided by Houndify.
 */
+ (void)setClientID:(NSString*)clientID;

/**
 @important This value must be set prior to using the SDK.
 @param clientKey The clientKey provided by Houndify.
 */
+ (void)setClientKey:(NSString*)clientKey;


/**
 WakeUpPattern is the language pattern (a subset of the Terrier language) used by the client to activate hot phrase detection.
 The default value is "[[\"OK\"] . (\"Sound\"|\"Sound Hound\"|\"Hound\")]". If you do NOT have a custom wake-up phrase, it is highly recommended to leave this value alone. This would include the majority of HoundifySDK callers.
 If you DO have a custom wake up pattern, the pattern needs to be set here. This value should be set before initiating a voice query, as this is a value that is sent as part of the Request Info.
 Please note that the server does not handle wake-up phrase spotting, and setting this field does not activate hot phrase detection. That is handled by the property `enableHotPhraseDetection` on HoundVoiceSearch.
 Letting the server know your wake-up pattern is important, as it allows the server to ignore the wake-up phrase part of a query.
 More detail about this field can be found in the documentation: https://docs.houndify.com/reference/RequestInfo
 */
+ (void)setWakeUpPattern:(NSString*)wakeUpPattern;

/**
 Returns the current wake-up pattern being sent to the server.
 */
+ (NSString*)wakeUpPattern;


/**
 Clears the current conversation state. Subsequent queries will start anew and not following an existing conversation flow.
 */
+ (void)clearConversationState;


/**
 This method updates the conversation state from a particular dynamic response. It also updates a command object with the properties of a dynamic response.
 Dynamic responses are alternate responses the client may choose to show to the user. This object may be provided as an NSDictionary or HoundDataDynamicResponse.

 @param dynamicResponse A dynamic response returned from a query. 
 @param commandResult A command result object to be updated (optional).
 */
+ (void)handleDynamicResponse:(id)dynamicResponse andUpdateCommandResult:(HoundDataCommandResult  * _Nullable)commandResult;

/**
 Use setPhraseSpotterThreshold to adjust the sensitivity for phrase spotting.  Valid values are in the range [0..1]
 The default value is 0.45.
 With lower values the phrase spotter will trigger more frequently, capturing the wakeup phrase more often, but with increased chance for false positives.
 Conversely, with higher values the phrase spotter will trigger less frequently, possibly missing the wakeup phrase more often, but with a lower false positive rate
 Use getPhraseSpotterThreshold to obtain the current threshold setting.
 */
+ (void)setPhraseSpotterThreshold:(float)threshold;
+ (float)getPhraseSpotterThreshold;

/* Debug Logging
 *
 * Note: All debug logging is stored in a file located in the application's Documents folder.
 * To access through iTunes, add the boolean flag 'UIFileSharingEnabled' to YES in your info.plist.
 * iTunes will then display anything you save in the Documents directory in your app by going to the Apps page in iTunes.
 *
 * In Xcode, you can also download the app data by going to:
 * Window > Devices > Select your app under Installed Apps > Settings Gear Icon > Download Container
 */

/**
 @return The currently active logging options
 */
+ (HoundLoggingOption)loggingOptions;

/**
 This method allows the SDK user to set logging options to help with debugging. You can select any combination of logging options. HoundLoggingOptions include:
 
 HoundLoggingOptionNone - Default
 HoundLoggingOptionSpeexArchive - Saves the speex archive to the default path, identical to what is streamed during a voice search.
 HoundLoggingOptionAudioChain - Logs the data flowing from the microphone to the file streamer
 HoundLoggingOptionAudioSession - Use this option to log property values associated with the shared AVAudioSession. If this is set to YES, the audio session state will be logged when the property is set, just before listening begins for the voice search, and again once a response is recieved.
 
 @param loggingOption The logging option to be set.
 */
+ (void)setLoggingOption:(HoundLoggingOption)loggingOption;

@end
NS_ASSUME_NONNULL_END
