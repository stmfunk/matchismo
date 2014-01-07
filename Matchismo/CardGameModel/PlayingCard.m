//
//  PlayingCard.m
//  Matchismo
//
//  Created by Donal O'Shea on 26/12/2013.
//  Copyright (c) 2013 Donal O'Shea. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (int)match:(NSArray *)otherCards {
    int score = 0;
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = 4;
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score = 1;
        }
    } else if ([otherCards count] == 2) {
        score = [self match:@[[otherCards firstObject]]] + [self match:@[[otherCards lastObject]]];
        NSLog(@"%d", score);
    }
    
    return score;
}

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *)validSuits {
    return @[@"♥",@"♦",@"♠",@"♣"];
}

+ (NSArray *)rankStrings {
    return @[@"?",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",
             @"J",@"Q",@"K"];
}

- (void)setSuit:(NSString *) suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count]-1;
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
