//
//  NSObject+SHCategory.m
//  BasicFramework
//
//  Created by u1city on 2019/12/19.
//  Copyright © 2019 u1city. All rights reserved.
//

#import "NSObject+SHCategory.h"

@implementation NSObject (SHCategory)

- (BOOL)isInt:(nonnull id)number {
    NSScanner *scanner = [NSScanner scannerWithString:[NSString stringWithFormat:@"%@",number]];
    int val;
    return [scanner scanInt:&val] && [scanner isAtEnd];
}

- (BOOL)isInteger:(nonnull id)number {
    NSScanner *scanner = [NSScanner scannerWithString:[NSString stringWithFormat:@"%@",number]];
    NSInteger val;
    return [scanner scanInteger:&val] && [scanner isAtEnd];
}

@end
