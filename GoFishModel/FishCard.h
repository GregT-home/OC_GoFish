//
//  FishCard.h
//  GoFish Model
//
//  Created by Greg Tarsa on 1/23/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import <Foundation/Foundation.h>
#define RANKS [@"2 3 4 5 6 7 8 9 10 J Q K A" componentsSeparatedByString:@" "]
#define SUITS [@"C D H S" componentsSeparatedByString:@" "]

@interface FishCard : NSObject
@property NSString *rank;
@property NSString *suit;

+ (instancetype) newWithRank:(NSString *)rank suit:(NSString *)suit;
- (instancetype) initWithRank:(NSString *)rank suit:(NSString *)suit;
- (NSComparisonResult) compare:(FishCard *)aCard;
- (NSString *) description;
- (NSString *) BasicFileBaseName;
- (NSString *) FancyFileBaseName;

@end
