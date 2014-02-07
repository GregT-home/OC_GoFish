//
//  FishPlayer.h
//  GoFishModel
//
//  Created by Greg Tarsa on 2/4/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "GoFishModel.h"
#import "FishHand.h"

@interface FishPlayer : NSObject <NSCopying>

@property (nonatomic) NSNumber *number;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) FishHand *hand;

+ (instancetype)newWithNumber:(NSNumber *)number name:(NSString *)name hand:(FishHand *)hand;
- (NSNumber *)numberOfCards;
- (void)tell:(NSString *)msg;
- (NSArray *)messages:(BOOL)consume;
- (BOOL)messagesWaiting;

@end
