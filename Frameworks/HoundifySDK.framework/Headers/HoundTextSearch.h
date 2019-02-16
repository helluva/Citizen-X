//
//  HoundTextSearch.h
//  HoundSDK
//
//  Created by Cyril Austin on 5/20/15.
//  Copyright (c) 2015 SoundHound, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HoundSDKServerDataModels.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const HoundTextSearchDefaultEndpoint;

#pragma mark - Callbacks

/**
 HoundTextSearchCallback

 @param error Text search error returned by the server. Nullable.
 @param query Text query submitted.
 @param houndServer A HoundDataHoundServer object.
 @param dictionary A JSON representation of the response.
 @param requestInfo A JSON representation of the request info.
 */
typedef void (^HoundTextSearchCallback)(
    NSError* __nullable error,
    NSString* query,
    HoundDataHoundServer* __nullable houndServer,
    NSDictionary<NSString*, id>* __nullable dictionary,
    NSDictionary<NSString*, id>* __nullable requestInfo
);

#pragma mark - HoundTextSearch

@interface HoundTextSearch : NSObject

/**
 A flag indicating if the SDK is currently executing a text search.
 */
@property(nonatomic, assign, readonly) BOOL textSearchActive;

/**
 Returns a singleton instance of HoundTextSearch.
 */
+ (instancetype)instance;

/**
 Performs text-based Hound queries using the default endpoint, results are returned in the completion handler.
 
 @remark Note (1): The caller should populate the location keys in requestInfo. The SDK does not manage the user location.
 For a full description of parameters, refer to: https://houndify.com/reference/RequestInfo
 
 @param query Text query
 @param requestInfo A dictionary containing extra parameters for the search.
                     The following keys are set by default if not supplied by the caller:
                     UserID, RequestID, TimeStamp, TimeZone, ClientID, ClientVersion, DeviceID, ConversationState, UnitPreference, PartialTranscriptsDesired, ObjectByteCountPrefix, SDK, SDKVersion
 @param handler The completion handler.
 */
- (void)searchWithQuery:(NSString*)query
    requestInfo:(NSDictionary<NSString*, id>* __nullable)requestInfo
    completionHandler:(HoundTextSearchCallback __nullable)handler;

/**
 Performs text-based Hound queries, results are returned in the completion handler.
 Use the method above if you are not using a custom endpoint for text search.

 @remark Note (1): The caller should populate the location keys in requestInfo. The SDK does not manage the user location.
 
 @param query Text query
 @param requestInfo A dictionary containing extra parameters for the search.
                     The following keys are set by default if not supplied by the caller:
                     UserID, RequestID, TimeStamp, TimeZone, ClientID, ClientVersion, DeviceID, ConversationState, UnitPreference, PartialTranscriptsDesired, ObjectByteCountPrefix, SDK, SDKVersion
                     For a full description of parameters, refer to: https://houndify.com/reference/RequestInfo
 @param endPointURL The URL for a custom Houndify text search endpoint.
 @param handler The completion handler.
 */
- (void)searchWithQuery:(NSString*)query
    requestInfo:(NSDictionary<NSString*, id>* __nullable)requestInfo
    endPointURL:(NSURL*)endPointURL
    completionHandler:(HoundTextSearchCallback __nullable)handler;

/**
 Cancels the currently in progress text search.
 */
- (void)cancelSearch;

@end

NS_ASSUME_NONNULL_END
