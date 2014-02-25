//
//  SetCard.h
//  Matchismo
//
//  Created by Donal O'Shea on 18/02/2014.
//  Copyright (c) 2014 Donal O'Shea. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger number;
@property (strong,  nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) UIColor *color;

+ (NSUInteger)maxNumber;
+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSArray *)validColors;

@end
