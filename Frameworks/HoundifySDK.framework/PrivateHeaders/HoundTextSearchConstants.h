//
//  HoundTextSearchConstants.h
//  HoundSDK
//
//  Created by Cyril Austin on 12/10/15.
//  Copyright © 2015 SoundHound, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Errors

extern NSString* HoundTextSearchErrorDomain;

#pragma mark - HoundVoiceSearchErrorCode

typedef NS_ENUM(NSUInteger, HoundTextSearchErrorCode)
{
    HoundTextSearchErrorCodeNone,
    HoundTextSearchErrorCodeAuthenticationFailed,
    HoundTextSearchErrorCodeServerStatusError
};

NS_ASSUME_NONNULL_END