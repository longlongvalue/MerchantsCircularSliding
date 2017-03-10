//
//  CellInfoDataModel.h
//  MerchantsCircularSliding
//
//  Created by 淘卡淘 on 2017/3/9.
//  Copyright © 2017年 taokatao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellInfoDataModel : NSObject

/**
 标题
 */
@property (nonatomic, copy) NSString *title;

/**
 子标题
 */
@property (nonatomic, copy) NSString *subTitle;

/**
 单元格左左图片
 */
@property (nonatomic, copy) NSString *leftImageNameStr;

/**
 单元格背景图片
 */
@property (nonatomic, copy) NSString *backImageNameStr;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
