//
//  HoundDataModels.h
//  Hound Command Parser
//
//  Created by Cyril Austin on 6/4/15.
//  Copyright (c) 2015 SoundHound, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - HoundData

@interface HoundData : NSObject

@property(nullable, nonatomic, strong, readonly) NSDictionary* _dictionary;

#if !IGNORE_SUBSCRIPT_OPERATOR

- (id __nullable)objectForKeyedSubscript:(NSString*)key;

#endif

@end

#pragma mark - HoundDataArray

@interface HoundDataArray : NSObject<NSFastEnumeration>

@property(nullable, nonatomic, strong) NSMutableArray* array;

- (instancetype)initWithArray:(NSArray*)array;

- (NSUInteger)count;

- (id __nullable)firstObject;
- (id __nullable)lastObject;

- (void)addObject:(id)object;
- (void)addObjectsFromArray:(NSArray*)array;

- (void)removeObjectAtIndex:(NSUInteger)index;

- (id)objectAtIndexedSubscript:(NSUInteger)index;

- (void)setObject:(id)object atIndexedSubscript:(NSUInteger)index;

@end

#pragma mark - HoundDataStringArray

@interface HoundDataStringArray : HoundDataArray

@end

#pragma mark - HoundDataNumberArray

@interface HoundDataNumberArray : HoundDataArray

@end

#pragma mark - HoundDataURLArray

@interface HoundDataURLArray : HoundDataArray

@end

NS_ASSUME_NONNULL_END