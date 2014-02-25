//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Donal O'Shea on 25/02/2014.
//  Copyright (c) 2014 Donal O'Shea. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init {
    self = [super init];
    if (self) {
        for (NSString *symbol in [SetCard validSymbols])
            for (NSUInteger number = 1; number <= [SetCard maxNumber]; number++)
                for (NSString *shading in [SetCard validShadings])
                    for (UIColor *color in [SetCard validColors]) {
                        SetCard *card = [[SetCard alloc] init];
                        card.symbol = symbol;
                        card.number = number;
                        card.shading = shading;
                        card.color = color;
                        [self addCard:card];
                    }
    }
    return self;
}

@end
