//
//  CellInfoDataModel.m
//  MerchantsCircularSliding
//
//  Created by 淘卡淘 on 2017/3/9.
//  Copyright © 2017年 taokatao. All rights reserved.
//

#import "CellInfoDataModel.h"

@implementation CellInfoDataModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"CellInfoDataModel中出现未定义KEY，请检查你自定义的模型字段是否一致");
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self == [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
