//
//  HoundVoiceSearchConstants.h
//  HoundSDK
//
//  Created by Cyril Austin on 10/9/15.
//  Copyright © 2015 SoundHound, Inc. All rights reserved.
//

#ifndef HoundVoiceSearchConstants_h
#define HoundVoiceSearchConstants_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Notifications

extern NSString* HoundVoiceSearchStateChangeNotification;
extern NSString* HoundVoiceSearchHotPhraseNotification;
extern NSString* HoundVoiceSearchAudioLevelNotification;
extern NSString* HoundVoiceSearchPartialTranscriptionNotification;
extern NSString* HoundVoiceSearchFinalTranscriptionNotification;

#pragma mark - Errors

extern NSString* HoundVoiceSearchErrorDomain;

#pragma mark - HoundVoiceSearchErrorCode

typedef NS_ENUM(NSUInteger, HoundVoiceSearchErrorCode)
{
    HoundVoiceSearchErrorCodeNone,                  // 0
    HoundVoiceSearchErrorCodeCancelled,             // 1
    HoundVoiceSearchErrorCodeNotReady,              // 2
    HoundVoiceSearchErrorCodeServerStatusError,     // 3
    HoundVoiceSearchErrorCodeServerNoAudioError,    // 4
    HoundVoiceSearchErrorCodeNoResponseReceived,    // 5
    HoundVoiceSearchErrorCodeInvalidResponse,       // 6
    HoundVoiceSearchErrorCodeAudioInterrupted,      // 7
    HoundVoiceSearchErrorCodeParseFailed,           // 8
    HoundVoiceSearchErrorCodeAuthenticationFailed,  // 9
    HoundVoiceSearchErrorCodeInternalError,         // 10
    HoundVoiceSearchErrorCodePermissionDenied,      // 11
    HoundVoiceSearchErrorCodeApplicationNotActive,  // 12
    HoundVoiceSearchErrorCodeConnectionFailure,     // 13
    HoundVoiceSearchErrorCodeConnectionTimeout      // 14
};

NSString * houndVoiceSearchErrorDescriptionForCode(NSUInteger code);

#pragma mark - HoundVoiceSearchState

typedef NS_ENUM(NSUInteger, HoundVoiceSearchState)
{
    HoundVoiceSearchStateNone,
    HoundVoiceSearchStateReady,
    HoundVoiceSearchStateRecording,
    HoundVoiceSearchStateSearching,
    HoundVoiceSearchStateSpeaking
};

#pragma mark - HoundifyStyle

@interface HoundifyStyle : NSObject

@property(nullable, nonatomic, strong) UIColor* backgroundColor;
@property(nullable, nonatomic, strong) UIColor* backgroundOverlayColor;
@property(nullable, nonatomic, copy) NSString* fontName;
@property(nullable, nonatomic, strong) UIColor* textColor;
@property(nullable, nonatomic, strong) UIColor* buttonTintColor;
@property(nullable, nonatomic, strong) UIColor* ringColor;
@property(nonatomic, assign) BOOL useWhiteAttribution;
@property(nullable, nonatomic, weak) id helpTarget;
@property(nullable, nonatomic, assign) SEL helpSelector;
@property(nullable, nonatomic, copy) NSString* titleText;
@property(nullable, nonatomic, copy) NSString* subtitleText;
@property(nullable, nonatomic, copy) NSString* hintTitleText;
@property(nullable, nonatomic, copy) NSString* hintSubtitleText;

@end

NS_ASSUME_NONNULL_END

#endif
