//
//  ZBiPAModel.h
//  iPATools
//
//  Created by jumbo on 2021/5/10.
//  Copyright © 2021 @itzhangbao.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZBiPAModel : NSObject

@property (nonatomic, copy) NSString *_id;
/// 名称
@property (nonatomic, copy) NSString *name;
/// 下载链接
@property (nonatomic, copy) NSString *url;
/// 图标
@property (nonatomic, copy) NSString *icon;
/// 所占内存空间
@property (nonatomic, copy) NSString *size;
/// 简介
@property (nonatomic, copy) NSString *desc;
/// 标识
@property (nonatomic, copy) NSString *bundleid;
/// 版本号
@property (nonatomic, copy) NSString *version;
/// 形容类型
@property (nonatomic, copy) NSString *type;
/// 文件类型
@property (nonatomic, copy) NSString *extension;

/// 字典数组转模型数组
/// @param array 存储对应模型的字典数组
+ (NSMutableArray<ZBiPAModel *> *)modelsWithArray:(NSArray<NSDictionary *> *)array;

/// 数据模型转NSData
/// @param model 数据模型
+ (NSData *)dataWithModel:(ZBiPAModel *)model;

/// NSData类型转数据模型
/// @param data NSData实例
+ (ZBiPAModel *)modelWithData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
