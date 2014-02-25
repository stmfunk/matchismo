//
//  SetCard.m
//  Matchismo
//
//  Created by Donal O'Shea on 18/02/2014.
//  Copyright (c) 2014 Donal O'Shea. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (NSString *)contents {
    return nil;
}

@synthesize number = _number;

- (void)setNumber:(NSUInteger)number {
    if ([SetCard maxNumber] > number) {
        _number = number;
    }
}

- (NSUInteger)number {
    if (!_number) _number = 0;
    return _number;
}

@synthesize symbol = _symbol;

- (void)setSymbol:(NSString *)symbol {
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (NSString *)symbol {
    if (!_symbol) _symbol = @"?";
    return _symbol;
}

@synthesize shading = _shading;

- (void)setShading:(NSString *)shading {
    if ([[SetCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

- (NSString *)shading {
    if (!_shading) _shading = @"?";
    return _shading;
}

@synthesize color = _color;

- (UIColor *)color {
    if (!_color) _color = [UIColor blackColor];
    return _color;
}

- (void)setColor:(UIColor *)color {
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

+ (NSUInteger)maxNumber {
    return 3;
}


+ (NSArray *)validSymbols {
    return @[@"Circle",@"Triangle",@"Square"];
}

+ (NSArray *)validShadings {
    return @[@"Striped",@"Solid",@"Open"];
}

+ (NSArray *)validColors {
    return @[[UIColor greenColor],[UIColor purpleColor],[UIColor redColor]];
}

@end
