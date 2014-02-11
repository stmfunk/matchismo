//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Donal O'Shea on 25/12/2013.
//  Copyright (c) 2013 Donal O'Shea. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentaryLabel;
@property (strong, nonatomic) NSMutableArray *cardButtonQueue;
@property (nonatomic) NSInteger lastScore;

- (void)appendToCardButtonQueueButton:(id)button;
- (NSString *)titleForCard:(Card *)card;
- (UIImage *)backgroundImageForCard:(Card *)card;
@end

@implementation CardGameViewController

- (NSInteger)lastScore {
    if (!_lastScore) _lastScore = 0;
    return _lastScore;
}

- (NSMutableArray *)cardButtonQueue {
    if (!_cardButtonQueue) _cardButtonQueue = [[NSMutableArray alloc] init];
    return _cardButtonQueue;
}

- (void)appendToCardButtonQueueButton:(id)button {
    NSInteger cardNum = [self.cardButtonQueue count];
    int i;
    if (cardNum < self.game.gameMode) i = cardNum;
    else {
        for (i = 0; i < self.game.gameMode; i++)
            self.cardButtonQueue[i] = self.cardButtonQueue[i+1];
    }
    self.cardButtonQueue[i] = button;
}

- (IBAction)touchGameMode:(id)sender {
    self.game.gameMode = [sender selectedSegmentIndex] ? 3 : 2;
}

- (CardMatchingGame *)game {
    if (!_game) _game = [[CardMatchingGame alloc]
                         initWithCardCount:[self.cardButtons count]
                         usingDeck:[self createDeck]];
    return _game;
}
- (Deck *)createDeck { // abstract
    return nil;
}

- (IBAction)redealCards:(id)sender {
    NSInteger gameMode = self.game.gameMode;
    [self.cardButtonQueue removeAllObjects];
    self.game = [[CardMatchingGame alloc]
                 initWithCardCount:[self.cardButtons count]
                 usingDeck:[self createDeck]];
    self.game.gameMode = gameMode;
    self.commentaryLabel.text = @"Pick a card!";
    [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    BOOL cardTouched = NO;
    for (id cardButton in self.cardButtonQueue) {
        if (cardButton == sender) cardTouched = YES;
    }
    if (!cardTouched) [self appendToCardButtonQueueButton:sender];
    else [self.cardButtonQueue removeObject:sender];
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (void)updateUI {
    if ([self.cardButtonQueue count] == 0)
        self.commentaryLabel.text = @"Pick a card!";
    else if ([self.cardButtonQueue count] == 1) {
        Card *selectedCard = [self.game cardAtIndex:[self.cardButtons indexOfObject:
                                                     [self.cardButtonQueue firstObject]]];
        self.commentaryLabel.text = selectedCard.contents;
    } else if ([self.cardButtonQueue count] == 2 && self.game.gameMode == 3) {
        Card *selectedCardOne = [self.game cardAtIndex:[self.cardButtons indexOfObject:
                                                     [self.cardButtonQueue firstObject]]];
        Card *selectedCardTwo = [self.game cardAtIndex:[self.cardButtons indexOfObject:
                                                       [self.cardButtonQueue lastObject]]];
        self.commentaryLabel.text = [NSString stringWithFormat:@"%@, %@", selectedCardOne.contents, selectedCardTwo.contents];
    } else if ([self.cardButtonQueue count] == self.game.gameMode) {
        NSMutableArray *cardsToMatch = [[NSMutableArray alloc] init];
        for (id button in self.cardButtonQueue) {
            [cardsToMatch addObject:[self.game cardAtIndex:[self.cardButtons indexOfObject:button]]];
        }
        NSString *matchedCardsString = @"";
        for (Card *card in cardsToMatch)
            matchedCardsString = [matchedCardsString stringByAppendingString:card.contents];
        Card *cardToMatch = [cardsToMatch firstObject];
        [cardsToMatch removeObject:cardToMatch];
        int match = [cardToMatch match:cardsToMatch];
        int scoreChange = self.game.score - self.lastScore;
        if (match) {
            self.commentaryLabel.text = [NSString stringWithFormat:@"Matched %@ for %d points!", matchedCardsString, scoreChange];
        } else {
            self.commentaryLabel.text = [NSString stringWithFormat:@"%@ don't match!\n%d point penalty!", matchedCardsString, scoreChange];
        }
        id button = [self.cardButtonQueue lastObject];
        [self.cardButtonQueue removeAllObjects];
        [self appendToCardButtonQueueButton:button];
    }
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
    self.lastScore = self.game.score;
}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end