//
//  GllCollectionViewCell.m
//  TaoKaTaoCardPackage
//
//  Created by 淘卡淘 on 16/9/8.
//  Copyright © 2016年 taokatao. All rights reserved.
//

#import "GllCollectionViewCell.h"
#import "GllMainCell.h"

@interface GllCollectionViewCell()
{
    BOOL hasLayout;
}

@property(nonatomic, strong) NSURL *currentBackURL;
@property(nonatomic) NSUInteger cellIndex;

@end


@implementation GllCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        hasLayout = NO;
        self.clipsToBounds = YES;
        //根据当前CELL所在屏幕的不同位置，初始化IMAGEVIEW的相对位置，为了配合滚动时的IMAGEVIEW偏移动画
        //(screen_y-attributes.frame.origin.y)/568*80
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, IMAGEVIEW_ORIGIN_Y-self.frame.origin.y/568*IMAGEVIEW_MOVE_DISTANCE, CELL_WIDTH, SC_IMAGEVIEW_HEIGHT)];
        [self addSubview:self.imageView];
        
        self.maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CELL_WIDTH, 250)];
        self.maskView.backgroundColor = [UIColor blackColor];
        self.maskView.alpha = 0.6;
        [self addSubview:self.maskView];
        
        self.leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, (CELL_HEIGHT - CELL_WIDTH * 0.2) * 0.5, 60, 60)];
        
        self.leftImageView.layer.cornerRadius = 10;
        self.leftImageView.layer.masksToBounds = YES;
        [self addSubview:self.leftImageView];
        
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_MARGINX, (CELL_HEIGHT-TITLE_HEIGHT)/2, CELL_WIDTH, TITLE_HEIGHT)];
        self.title.textColor = [UIColor blackColor];
        self.title.font = [UIFont systemFontOfSize:30];
        self.title.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.title];
        self.contentMode = UIViewContentModeCenter;
        self.title.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1);
        [self.title setBackgroundColor:[UIColor clearColor]];
        
        self.desc = [[UILabel alloc] initWithFrame:CGRectMake(0, (CELL_HEIGHT-TITLE_HEIGHT)/2+30,CELL_WIDTH - CGRectGetMaxX(self.leftImageView.frame) - TITLE_MARGINX, 30)];
        self.desc.textColor = [UIColor blackColor];
        self.desc.font = [UIFont systemFontOfSize:15];
        self.desc.alpha = 0;
        self.desc.textAlignment = NSTextAlignmentLeft;
        self.desc.backgroundColor = [UIColor clearColor];
        [self addSubview:self.desc];
        
    }
    return self;
}

-(void)revisePositionAtFirstCell
{
    if(self.tag == 1){
        
        //单元格左图片的放大缩小动画
        self.leftImageView.layer.transform = CATransform3DMakeScale(1+0.2, 1+0.2, 1);
        
        CGRect leftImageViewFrame = self.leftImageView.frame;
        leftImageViewFrame.origin.y = CGRectGetMaxY(self.frame) - CGRectGetWidth(self.leftImageView.frame) - (CELL_HEIGHT - CELL_WIDTH * 0.2) * 0.5;
        self.leftImageView.frame = leftImageViewFrame;
        
        self.title.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1);
        
        self.desc.alpha = 0.85;
        //        self.title.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, self.contentView.center.y);
        
        self.title.frame = CGRectMake(CGRectGetMaxX(leftImageViewFrame) + TITLE_MARGINX, CGRectGetMinY(leftImageViewFrame) + (CGRectGetHeight(leftImageViewFrame) - CGRectGetHeight(self.title.frame)) * 0.5 - (CGRectGetHeight(leftImageViewFrame) - CGRectGetHeight(self.title.frame)) * 0.4, self.title.frame.size.width, self.title.frame.size.height);
        
        self.desc.frame = CGRectMake(CGRectGetMinX(self.title.frame), CGRectGetMaxY(self.leftImageView.frame) - CGRectGetHeight(self.desc.frame), self.desc.frame.size.width, self.desc.frame.size.height);
        
    }
}

-(void)setIndex:(NSUInteger)index
{
    self.cellIndex = index;
    if (self.cellIndex == 0) {
        
        self.maskView.alpha = 0;
        self.backgroundColor = [UIColor lightGrayColor];
        
    }else if(self.cellIndex == 1){
        
        self.maskView.alpha = 0;
        self.backgroundColor = [UIColor blackColor];
        
    }else{
        
        self.maskView.alpha = 0.6;
        self.backgroundColor = [UIColor blackColor];
        
    }
    [self setImageViewPostion];
}

-(void)setImageViewPostion
{
    if (self.imageView) {
        self.imageView.frame = CGRectMake(0, IMAGEVIEW_ORIGIN_Y-self.frame.origin.y/568*IMAGEVIEW_MOVE_DISTANCE, CELL_WIDTH, SC_IMAGEVIEW_HEIGHT);
    }
}

-(void)setNameLabel:(NSString *)string
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    self.title.attributedText = str;
}

-(void)setDescLabel:(NSString *)string
{
    if(string == nil || [string isEqualToString:@""]){
        return;
    }
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
    self.desc.attributedText = str;
    //    self.desc.frame = CGRectMake(10, self.desc.frame.origin.y, 300, 30);
}

/**
 *  重置属性
 */
-(void)reset
{
    self.imageView.image = nil;
    self.title.text = @"";
    self.desc.text = @"";
}

-(void)dealloc
{
    self.imageView = nil;
    self.maskView = nil;
    self.title = nil;
}


@end
