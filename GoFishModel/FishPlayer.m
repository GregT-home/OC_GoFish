//
//  FishPlayer.m
//  GoFishModel
//
//  Created by Greg Tarsa on 2/4/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import "FishPlayer.h"

@implementation FishPlayer {
    NSMutableArray *messagesArray;
}

- (instancetype)initWithNumber:(NSNumber *)number name:(NSString *)name hand:(FishHand *)hand {
    self = [super init];
    if (self) {
        self.number = number;
        self.name = name;
        self.hand = hand;
    }
    return self;
}

+ (instancetype)newWithNumber:(NSNumber *)number name:(NSString *)name hand:(FishHand *)hand {
    return[[self alloc] initWithNumber:number name:name hand:hand];
}

- (instancetype)copyWithZone:(NSZone *)zone {
    FishPlayer *copy = [[[self class] allocWithZone: zone] init];
    [copy setName:[self name]];
    [copy setNumber:[self number]];
    [copy setHand:[self hand]];
    return copy;
}


- (NSNumber *)numberOfCards {
    return [self.hand numberOfCards];
}

- (void)tell:(NSString *)msg {
    if (messagesArray == nil)
        messagesArray = [@[] mutableCopy];
    [messagesArray addObject:msg];
}

- (NSArray *)messages:(BOOL)consume {
    NSArray *currentList = messagesArray;
    if (consume)
        messagesArray = [@[] mutableCopy];
    return currentList;
}

- (BOOL)messagesWaiting {
    return ([messagesArray count] > 0);
    
}
@end
