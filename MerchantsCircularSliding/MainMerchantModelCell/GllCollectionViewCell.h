//
//  GllCollectionViewCell.h
//  TaoKaTaoCardPackage
//
//  Created by 淘卡淘 on 16/9/8.
//  Copyright © 2016年 taokatao. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GllMainCellDelegate <NSObject>

@optional

-(void)switchNavigator:(NSUInteger)tag;

@end

@interface GllCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UIImageView *leftImageView;
@property(nonatomic, strong) UIView *maskView;
@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) UILabel *desc;

-(void)setNameLabel:(NSString *)string;
-(void)setDescLabel:(NSString *)string;
-(void)setIndex:(NSUInteger)index;
-(void)revisePositionAtFirstCell;
-(void)reset;
@property (nonatomic, weak) id<GllMainCellDelegate> delegate;

@end
