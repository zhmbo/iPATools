//
//  NSString+ZBKit.m
//  iPATools
//
//  Created by jumbo on 2021/5/20.
//  Copyright © 2021 @itzhangbao.com. All rights reserved.
//

#import "NSString+ZBKit.h"

@implementation NSString (ZBKit)

- (NSString *(^)(id newValue))a {
    return ^(id newValue) {
        return [NSString stringWithFormat:@"%@%@",self,newValue];
    };
}

- (NSString *)zb_urlEncode {
    NSString * charaters = @"?!@#$^&%*+,:;='\"`<>()[]{}/\\| ";
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:charaters] invertedSet];
    NSString *encodeString = [self stringByAddingPercentEncodingWithAllowedCharacters:set];
    return encodeString;
}

- (NSString *)zb_base64 {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64Str = [data base64EncodedStringWithOptions:0];
    return base64Str;
}

- (BOOL)zb_isNull {
    if (!self) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (self == nil) {
        return YES;
    }
    if ([self isEqual:[NSNull null]]) {
        return YES;
    }
    if (![self isKindOfClass:[NSString class]]) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [self stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}

@end
