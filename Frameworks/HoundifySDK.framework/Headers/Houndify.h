//
//  Houndify.h
//  HoundifySDK
//
//  Created by Cyril Austin on 10/29/15.
//  Copyright © 2015 SoundHound, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HoundVoiceSearchConstants.h"

NS_ASSUME_NONNULL_BEGIN

@class HoundDataHoundServer;

#pragma mark - Callbacks

typedef void (^HoundifyResponseCallback)(
    NSError* __nullable error,
    id __nullable response,
    NSDictionary<NSString*, id>* __nullable dictionary,
    NSDictionary<NSString*, id>* __nullable requestInfo
);

typedef void (^HoundifyCompletionHandler)(void);

#pragma mark - Houndify

/**
 The Houndify class allows high-level basic operations on the Houndify SDK.
 */
@interface Houndify : NSObject

/**
 Returns the singlton instance of the Houndify object.
 */
+ (instancetype)instance;

/**
 This method initiates a voice search and starts a full screen takeover with the Hound user interface.
 
 @param presentingViewController The view controller that will present the Hound user interface.
                                 Typically this is the root view controller for the main window, such as a UINavigationController or UITabBarController.
 @param presentingView The view to start the voice search animation.
                         The HoundifySDK will center the launch animation on this view's position.
 @param style A HoundifyStyle object used to configure the look of the search UI.
 @param requestInfo A dictionary containing extra parameters for the search.
                     The following keys are set by default if not supplied by the caller:
                     UserID, RequestID, TimeStamp, TimeZone, ClientID, ClientVersion, DeviceID, ConversationState, UnitPreference, PartialTranscriptsDesired, ObjectByteCountPrefix, SDK, SDKVersion
                     Note (1): The caller should populate the location keys in this dictionary. The SDK does not manage the user location.
                     For a full description of parameters, refer to: https://houndify.com/reference/RequestInfo
 @param responseHandler This callback is invoked during the search and may be called multiple times with different values.
 */
- (void)presentListeningViewControllerInViewController:(UIViewController*)presentingViewController
    fromView:(UIView* __nullable)presentingView
    style:(HoundifyStyle* __nullable)style
    requestInfo:(NSDictionary<NSString*, id>* __nullable)requestInfo
    responseHandler:(HoundifyResponseCallback)responseHandler;

/**
 This method initiates a voice search and starts a full screen takeover with the Hound user interface using a custom Houndify endpoint.
 Use the method above if you are not using a custom endpoint for voice search.
 
 @param presentingViewController The view controller that will present the Hound user interface.
                                 Typically this is the root view controller for the main window, such as a UINavigationController or UITabBarController.
 @param presentingView The view to start the voice search animation.
                         The HoundifySDK will center the launch animation on this view's position.
 @param style A HoundifyStyle object used to configure the look of the search UI.
 @param requestInfo A dictionary containing extra parameters for the search.
                     The following keys are set by default if not supplied by the caller:
                     UserID, RequestID, TimeStamp, TimeZone, ClientID, ClientVersion, DeviceID, ConversationState, UnitPreference, PartialTranscriptsDesired, ObjectByteCountPrefix, SDK, SDKVersion
                     Note (1): The caller should populate the location keys in this dictionary. The SDK does not manage the user location.
                     For a full description of parameters, refer to: https://houndify.com/reference/RequestInfo
 @param endPointURL The URL for a custom Houndify voice search endpoint.
 @param responseHandler This callback is invoked during the search and may be called multiple times with different values.
 */
- (void)presentListeningViewControllerInViewController:(UIViewController*)presentingViewController
    fromView:(UIView* __nullable)presentingView
    style:(HoundifyStyle* __nullable)style
    requestInfo:(NSDictionary<NSString*, id>* __nullable)requestInfo
    endPointURL:(NSURL*)endPointURL
    responseHandler:(HoundifyResponseCallback)responseHandler;

/**
 This method initiates a voice search and starts a full screen takeover with the Hound user interface.
 
 @param presentingViewController The view controller that will present the Hound user interface.
                                 Typically this is the root view controller for the main window, such as a UINavigationController or UITabBarController.
 @param point The position in the presentingViewController's view to start the voice search.
                    The Houndify SDKwill center the launch animation on this point.
 @param style A HoundifyStyle object used to configure the look of the search UI.
 @param requestInfo A dictionary containing extra parameters for the search.
                     The following keys are set by default if not supplied by the caller:
                     UserID, RequestID, TimeStamp, TimeZone, ClientID, ClientVersion, DeviceID, ConversationState, UnitPreference, PartialTranscriptsDesired, ObjectByteCountPrefix, SDK, SDKVersion
                     Note (1): The caller should populate the location keys in this dictionary. The SDK does not manage the user location.
                    For a full description of parameters, refer to: https://houndify.com/reference/RequestInfo
 @param responseHandler This callback is invoked during the search and may be called multiple times with different values.
 */
- (void)presentListeningViewControllerInViewController:(UIViewController*)presentingViewController
    fromPoint:(CGPoint)point
    style:(HoundifyStyle* __nullable)style
    requestInfo:(NSDictionary<NSString*, id>* __nullable)requestInfo
    responseHandler:(HoundifyResponseCallback)responseHandler;

/**
 This method initiates a voice search and starts a full screen takeover with the Hound user interface using a custom Houndify endpoint.
 Use the method above if you are not using a custom endpoint for voice search.
 
 @param presentingViewController The view controller that will present the Hound user interface.
                                 Typically this is the root view controller for the main window, such as a UINavigationController or UITabBarController.
 @param point The position in the presentingViewController's view to start the voice search.
                The Houndify SDKwill center the launch animation on this point.
 @param style A HoundifyStyle object used to configure the look of the search UI.
 @param requestInfo A dictionary containing extra parameters for the search.
                     The following keys are set by default if not supplied by the caller:
                     UserID, RequestID, TimeStamp, TimeZone, ClientID, ClientVersion, DeviceID, ConversationState, UnitPreference, PartialTranscriptsDesired, ObjectByteCountPrefix, SDK, SDKVersion
                     Note (1): The caller should populate the location keys in this dictionary. The SDK does not manage the user location.
                     For a full description of parameters, refer to: https://houndify.com/reference/RequestInfo
 @param endPointURL The URL for a custom Houndify voice search endpoint.
 @param responseHandler This callback is invoked during the search and may be called multiple times with different values.
 */
- (void)presentListeningViewControllerInViewController:(UIViewController*)presentingViewController
    fromPoint:(CGPoint)point
    style:(HoundifyStyle* __nullable)style
    requestInfo:(NSDictionary<NSString*, id>* __nullable)requestInfo
    endPointURL:(NSURL*)endPointURL
    responseHandler:(HoundifyResponseCallback)responseHandler;


/**
 This method dismisses the listening view controller and cancels a search if it is in progress.
 
 This method must be called once a response is received to remove the Houndify user interface from the screen.
 
 @param animated A flag indicating if the dismiss should be animated or not.
 @param completionHandler This callback is invoked once the Hound user interface is dismissed.
                            The callback has no parameters.
 */
- (void)dismissListeningViewControllerAnimated:(BOOL)animated
    completionHandler:(HoundifyCompletionHandler __nullable)completionHandler;
    
@end

NS_ASSUME_NONNULL_END
