//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Donal O'Shea on 06/01/2014.
//  Copyright (c) 2014 Donal O'Shea. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@end

@implementation CardMatchingGame

- (NSInteger)gameMode {
    if (_gameMode == 0) _gameMode = 2;
    return _gameMode;
}

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck {
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    NSMutableArray *chosenCards = [[NSMutableArray alloc] init];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            // match against other cards
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [chosenCards addObject:otherCard];
                    if ((self.gameMode-1) == [chosenCards count])  {
                        NSUInteger matchScore = [card match:chosenCards];
                        NSLog(@"%d", matchScore);
                        if (matchScore) {
                            self.score += matchScore * MATCH_BONUS;
                            for (Card *chosenCard in chosenCards) chosenCard.matched = YES;
                            card.matched = YES;
                            
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            for (Card *chosenCard in chosenCards) chosenCard.chosen = NO;
                        }
                    }
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

@end
