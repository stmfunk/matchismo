//
//  PlayingCard.h
//  Matchismo
//
//  Created by Donal O'Shea on 26/12/2013.
//  Copyright (c) 2013 Donal O'Shea. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
