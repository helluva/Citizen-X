//
//  HoundServerPartialTranscriptDataModels.h
//  SHHound
//
//  Created by Cyril Austin on 10/8/15.
//  Copyright © 2015 SoundHound. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HoundDataModels.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - HoundDataPartialTranscript

@interface HoundDataPartialTranscript : HoundData

@property(nonatomic, copy) NSString* format;
@property(nonatomic, copy) NSString* formatVersion;
@property(nonatomic, copy) NSString* partialTranscript;
@property(nonatomic, assign) NSUInteger durationMS;
@property(nonatomic, assign) BOOL done;
@property(nonatomic, assign) BOOL safeToStopAudio;

@end

NS_ASSUME_NONNULL_END