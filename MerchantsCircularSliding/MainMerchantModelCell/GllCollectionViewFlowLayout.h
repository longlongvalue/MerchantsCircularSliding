//
//  GllCollectionViewFlowLayout.h
//  TaoKaTaoCardPackage
//
//  Created by 淘卡淘 on 16/9/8.
//  Copyright © 2016年 taokatao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GllCollectionViewFlowLayoutDelegate <NSObject>

@optional

-(void)setEffectOfHead:(CGFloat)offsetY;

/**
 *  实时更新底部UIView的Frame
 */
- (void)updateBotteomViewFrameWithMaxY:(CGFloat)MaxY;

@end

@interface GllCollectionViewFlowLayout : UICollectionViewFlowLayout


@property (nonatomic, weak) id<GllCollectionViewFlowLayoutDelegate> delegate;

-(void)setContentSize:(NSUInteger)count;

@end
