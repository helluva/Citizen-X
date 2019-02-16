//
//  HoundMusicSearch.h
//  HoundSDK
//
//  Created by Sean Kelly on 6/15/17.
//  Copyright © 2017 SoundHound, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - HoundMusicSearchState

typedef NS_ENUM(NSUInteger, HoundMusicSearchState)
{
    HoundMusicSearchStateNone,
    HoundMusicSearchStateRecording,
    HoundMusicSearchStateSearching,
};

#pragma mark - Callbacks

typedef void (^HoundMusicSearchCallback)(NSError* error, NSString* result);

#pragma mark - Notifications

extern NSString* HoundMusicSearchStateChangeNotification;

#pragma mark - HoundMusicSearch

@interface HoundMusicSearch : NSObject

@property (nonatomic, assign, readonly) HoundMusicSearchState state;

+ (instancetype)instance;

- (void)startSearchWithCompletionHandler:(HoundMusicSearchCallback)handler;
- (void)stopSearch;
- (void)cancelSearch;

@end
