//
//  FishResult.h
//  GoFishModel
//
//  Created by Greg Tarsa on 2/4/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "GoFishModel.h"
#import "FishPlayer.h"

@interface FishResult : NSObject
@property (nonatomic, strong, readonly) FishPlayer *requester;
@property (nonatomic, strong, readonly) FishPlayer *victim;
@property (nonatomic, strong, readonly) NSString *rank;
@property (nonatomic, strong) NSNumber *matches;
@property (nonatomic) BOOL receivedFromPlayer;
@property (nonatomic) BOOL receivedFromPond;
@property (nonatomic) BOOL bookMade;
@property (nonatomic, strong) NSString *surpriseRank;
@property (nonatomic) BOOL gameOver;

+ (instancetype)newWithPlayer:(FishPlayer *)requester victim:(FishPlayer *)victim targetRank:(NSString *)targetRank;
- (NSString *)description;
@end
