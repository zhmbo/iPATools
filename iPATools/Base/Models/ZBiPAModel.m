//
//  ZBiPAModel.m
//  iPATools
//
//  Created by jumbo on 2021/5/10.
//  Copyright © 2021 @itzhangbao.com. All rights reserved.
//

#import "ZBiPAModel.h"
#import <objc/runtime.h>

@implementation ZBiPAModel

+ (NSMutableArray<ZBiPAModel *> *)modelsWithArray:(NSArray<NSDictionary *> *)array {
    NSMutableArray *models = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        ZBiPAModel *model = [[ZBiPAModel alloc] initWithDict:dict];
        if ([model._id isKindOfClass:[NSNumber class]]) {
            model._id = [(NSNumber *)model._id stringValue];
        }
        [models addObject:model];
    }
    return models;
}

+ (NSData *)dataWithModel:(ZBiPAModel *)model {
    NSDictionary *dict = [model dictionaryWithValuesForKeys:[model getAllKeys]];
    return [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
}

+ (ZBiPAModel *)modelWithData:(NSData *)data {
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    ZBiPAModel *model = [[ZBiPAModel alloc] initWithDict:dict];
    return model;
}

// MARK: - Private
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (void)setNilValueForKey:(NSString *)key {}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (NSArray *)getAllKeys {
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList(self.class, &count);
    NSMutableArray *keys = [NSMutableArray array];
    for (int i=0; i<count; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        [keys addObject:[NSString stringWithUTF8String:name]];
    }
    return keys;
}

@end
