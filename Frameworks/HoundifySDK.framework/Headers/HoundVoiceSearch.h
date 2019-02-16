//
//  HoundVoiceSearch.h
//  HoundSDK
//
//  Created by Cyril Austin on 5/20/15.
//  Copyright (c) 2015 SoundHound, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HoundVoiceSearchConstants.h"
#import "HoundSDKServerDataModels.h"
#import "HoundServerPartialTranscriptDataModels.h"

extern NSString * _Nonnull const HoundVoiceSearchDefaultEndpoint;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - HoundVoiceSearchResponseType

typedef NS_ENUM(NSUInteger, HoundVoiceSearchResponseType)
{
    HoundVoiceSearchResponseTypeNone,
    HoundVoiceSearchResponseTypePartialTranscription,
    HoundVoiceSearchResponseTypeHoundServer
};

#pragma mark - Callbacks

typedef void (^HoundVoiceSearchErrorCallback)(NSError* __nullable error);

typedef void (^HoundVoiceSearchResponseCallback)(
    NSError* __nullable error,
    HoundVoiceSearchResponseType responseType,
    id __nullable response,
    NSDictionary<NSString*, id>* __nullable dictionary,
    NSDictionary<NSString*, id>* __nullable requestInfo
);

#pragma mark - HoundVoiceSearch

/**
 This class performs voice searches.
 
Voice searches support two (2) modes: automatic and raw. 

For use cases in many applications, automatic would be the most useful. In automatic mode, the SDK manages audio recording and playback within the application. This means that the AVAudioSession activation, category, and option settings will be managed by the SDK without any setup by the developer. The category is set to AVAudioSessionCategoryPlayAndRecord, with the options AVAudioSessionCategoryOptionDefaultToSpeaker and AVAudioSessionCategoryOptionAllowBluetooth. When startListeningWithCompletionHandler: is called, the AVAudioSession is activated and microphone audio is recorded by the SDK. When stopListeningWithCompletionHandler: is called, the AVAudioSession is deactivated and recording stops. While listening is active, you can initiate a search using the startSearchWithRequestInfo:responseHandler: method.

If your application already has audio management code that interacts with AVAudioSession, it is recommended to use raw mode. In raw mode, the caller is responsible for supplying audio data to the SDK. The SDK does nothing to AVAudioSession, which means it is the responsibility of the caller to ensure the audio session is ready and active. In order to get audio data from the microphone, the AVAudioSession category must be set as either AVAudioSessionCategoryPlayAndRecord or AVAudioSessionCategoryRecord. To initiate raw mode, first call setupRawModeWithInputSampleRate:completionHandler: with the sample rate used for the audio that will be passed into the SDK. The SDK receives the audio data from the caller by using the writeRawAudioData: method. Whenever you receive audio data from the microphone, pass the audio to the SDK using this method to ensure proper voice search behavior. Note that this means that startListeningWithCompletionHandler: and stopListeningWithCompletionHandler: are not a part of the raw mode process. 
 */
@interface HoundVoiceSearch : NSObject

/**
 returns the singleton instance of HoundVoiceSearch.
 */
+ (instancetype)instance;

/**
 The current state of voice search.
 */
@property(nonatomic, assign, readonly) HoundVoiceSearchState state;

/**
 A flag indicating if the SDK should automatically detect the Hound hot phrase.
 
 When this flag is enabled and the SDK is in receiving audio, then when the user speaks “OK Hound”, the SDK will post the HoundVoiceSearchHotPhraseNotification to all listeners.
 
 To support a hot phrase, an application is responsible for activating a voice search when this notification is observed.
 
 The default is YES.
 */
@property(nonatomic, assign) BOOL enableHotPhraseDetection;


/**
 A flag indicating if the SDK should automatically detect end of user speech.
 
 If NO, then the search will stay active until terminated by the server (~10 seconds of silence) or by the application. Otherwise, the search result is processed as soon as the user stops speaking.
 
 The default is YES.
 */
@property(atomic, assign) BOOL enableEndOfSpeechDetection;


/**
 A flag indicating if the SDK should automatically speak the response from the server.
 
 The default is YES.
 */
@property(atomic, assign) BOOL enableSpeech;

// Setup raw mode

/**
 This method places the SDK into raw search mode. This method is used when the application manages its own audio infrastructure.
 
 If the application doesn’t manage its own audio infrastructure, use 
        @code startListeningWithCompletionHandler: @endcode instead.

 @param inputSampleRate The sampling rate of the audio that will be passed into the SDK through <b>writeRawAudioData:</b>.
 @param handler This callback is invoked on the main thread when the initalization is complete.
 */
- (void)setupRawModeWithInputSampleRate:(double)inputSampleRate
    completionHandler:(HoundVoiceSearchErrorCallback __nullable)handler;

// Automatic search methods


/**
 This method places the SDK into listening mode. This must be successfully called before starting any automatic voice searches. This call is not used for raw searches.
 
 The SDK will automatically prompt the user for microphone permissions if necessary. If the user declines microphone permissions then an error will be returned through the handler.
 
  @note The AVAudioSession for the application will be placed in the AVAudioSessionCategoryPlayAndRecord category and AVAudioSessionModeDefault mode
 
 @param handler This callback is invoked on the main thread when the initalization is complete.
 */
- (void)startListeningWithCompletionHandler:(HoundVoiceSearchErrorCallback __nullable)handler;

/**
 This method stops the SDK from processing microphone input. The state transitions to HoundVoiceSearchStateNone. This call is not used for raw searches.
 
 Searches cannot be started when the SDK is not listening.

 @param handler This callback is invoked on the main thread when the listening is stopped.
 */
- (void)stopListeningWithCompletionHandler:(HoundVoiceSearchErrorCallback __nullable)handler;

// Voice search


/**
 This method initiates a voice search using the default URL. Audio is automatically recorded from the user and transmitted to the server.

 @param requestInfo A dictionary containing extra parameters for the search.
                     The following keys are set by default if not supplied by the caller:
                     UserID, RequestID, TimeStamp, TimeZone, ClientID, ClientVersion, DeviceID, ConversationState, UnitPreference, PartialTranscriptsDesired, ObjectByteCountPrefix, SDK, SDKVersion. See https://houndify.com/reference/RequestInfo
 @param responseHandler This callback is invoked during the search and may be called multiple times with different values. It is always called on the main thread.
 */
- (void)startSearchWithRequestInfo:(NSDictionary<NSString*, id>* __nullable)requestInfo
    responseHandler:(HoundVoiceSearchResponseCallback __nullable)responseHandler;

/**
 This method initiates a voice search. Audio is automatically recorded from the user and transmitted to the server.
 Use the method above if you are not using a custom endpoint for voice search.
 
 @param requestInfo A dictionary containing extra parameters for the search.
                     The following keys are set by default if not supplied by the caller:
                     UserID, RequestID, TimeStamp, TimeZone, ClientID, ClientVersion, DeviceID, ConversationState, UnitPreference, PartialTranscriptsDesired, ObjectByteCountPrefix, SDK, SDKVersion. See https://houndify.com/reference/RequestInfo
 @param endPointURL The URL for a custom Houndify voice search endpoint.
 @param responseHandler This callback is invoked during the search and may be called multiple times with different values. It is always called on the main thread.
 */
- (void)startSearchWithRequestInfo:(NSDictionary<NSString*, id>* __nullable)requestInfo
    endPointURL:(NSURL*)endPointURL
    responseHandler:(HoundVoiceSearchResponseCallback __nullable)responseHandler;

/**
 This method allows the caller to supply raw audio data. @code setupRawModeWithInputSampleRate @endcode must be called before writting raw audio data.
 
 @param data The data must be 16 bit, Linear PCM audio data. 16 Khz is ideal for optimal performance.
             This data is the same as returned by the AudioUnitRender API function in the iOS AudioToolbox framework.
 */
- (void)writeRawAudioData:(NSData*)data;

// General methods

/**
 This stops the SDK from listening to the user’s request, and transitions into the searching state.
 
 The search may also be stopped internally when the SDK detects end of user speech if the enableEndOfSpeechDetection flag is YES.
 */
- (void)stopSearch;

/**
 The method cancels the search in progress.
 */
- (void)cancelSearch;

/**
 If the response is currently being spoken, the method stops speech in progress.
 */
- (void)stopSpeaking;

@end

NS_ASSUME_NONNULL_END
