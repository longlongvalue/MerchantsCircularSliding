//
//  GllCollectionViewFlowLayout.m
//  TaoKaTaoCardPackage
//
//  Created by 淘卡淘 on 16/9/8.
//  Copyright © 2016年 taokatao. All rights reserved.
//

#import "GllCollectionViewFlowLayout.h"
#import "GllCollectionViewCell.h"
#import "GllMainCell.h"

@interface GllCollectionViewFlowLayout()
{
    
}

@property(nonatomic, assign) NSUInteger count;
@end


@implementation GllCollectionViewFlowLayout

-(id)init
{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(CELL_WIDTH, CELL_HEIGHT);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.minimumInteritemSpacing = 0;
        self.minimumLineSpacing = 0;
        
//        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, layout.collectionViewContentSize.height - SC_IMAGEVIEW_HEIGHT + 32, CELL_WIDTH, SC_IMAGEVIEW_HEIGHT - 32)];
//        
//        backView.backgroundColor = [UIColor blueColor];
//        
//        [gllCollectionView addSubview:backView];
//        
//        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CELL_WIDTH, TITLE_HEIGHT)];
//        titleLable.text = @"No More Data";
//        titleLable.textColor = [UIColor whiteColor];
//        titleLable.textAlignment = NSTextAlignmentCenter;
//        titleLable.backgroundColor = [UIColor blueColor];
//        [backView addSubview:titleLable];
        
    }
    return self;
}

-(void)setContentSize:(NSUInteger)count
{
    self.count = count;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(UICollectionViewLayoutAttributes *)initialLayoutAttributesForAppearingItemAtIndexPath:(NSIndexPath *)itemIndexPath
{
    UICollectionViewLayoutAttributes *attr = [self layoutAttributesForItemAtIndexPath:itemIndexPath];
    return attr;
}

-(CGSize)collectionViewContentSize
{
    
//FIXME:注释上面这行代码
    
    return CGSizeMake(CELL_WIDTH, HEADER_HEIGHT+DRAG_INTERVAL*self.count +([UIScreen mainScreen].bounds.size.height - DRAG_INTERVAL));
    
//FIXME:解注释下面这行代码
    
//    return CGSizeMake(CELL_WIDTH, HEADER_HEIGHT+DRAG_INTERVAL*self.count +([UIScreen mainScreen].bounds.size.height + (CELL_CURRHEIGHT - DRAG_INTERVAL)));
}

-(void)prepareLayout
{
    [super prepareLayout];
}

-(NSArray*)layoutAttributesForElementsInRect:(CGRect)rect
{
    
    float screen_y = self.collectionView.contentOffset.y;
    float current_floor = floorf((screen_y-HEADER_HEIGHT)/DRAG_INTERVAL)+1;
    float current_mod = fmodf((screen_y-HEADER_HEIGHT), DRAG_INTERVAL);
    float percent = current_mod/DRAG_INTERVAL;
    
    //计算当前应该显示在屏幕上的CELL在默认状态下应该处于的RECT范围，范围左右范围进行扩展，避免出现BUG
    //之前的方法采用所有ITEM进行布局计算，当ITEM太多后，会严重影响性能体验，所有采用这种方法
    CGRect correctRect;
    if(current_floor == 0 || current_floor == 1){ //因为导航栏和当前CELL的高度特殊，所有做特殊处理
        correctRect = CGRectMake(0, 0, 320, RECT_RANGE);
    }else{
        correctRect = CGRectMake(0, HEADER_HEIGHT+HEADER_HEIGHT+CELL_HEIGHT*(current_floor-2), CELL_WIDTH, RECT_RANGE);
    }
    
    NSArray* array = [super layoutAttributesForElementsInRect:correctRect];
    
    if(screen_y >= HEADER_HEIGHT){
        
        for(UICollectionViewLayoutAttributes *attributes in array){
            NSInteger row = attributes.indexPath.row;
            if(row < current_floor){
                attributes.zIndex = 0;
                attributes.frame = CGRectMake(0, (HEADER_HEIGHT-DRAG_INTERVAL)+DRAG_INTERVAL*row, CELL_WIDTH, CELL_CURRHEIGHT);
                
                [self setEffectViewAlpha:1 forIndexPath:attributes.indexPath];
            }else if(row == current_floor){
                attributes.zIndex = 1;
                attributes.frame = CGRectMake(0, (HEADER_HEIGHT-DRAG_INTERVAL)+DRAG_INTERVAL*row, CELL_WIDTH, CELL_CURRHEIGHT);
                
                [self setEffectViewAlpha:1 forIndexPath:attributes.indexPath];
            }else if(row == current_floor+1){
                attributes.zIndex = 2;
                attributes.frame = CGRectMake(0, attributes.frame.origin.y+(current_floor-1)*70-70*percent, CELL_WIDTH, CELL_HEIGHT+(CELL_CURRHEIGHT-CELL_HEIGHT)*percent);

                [self setEffectViewAlpha:percent forIndexPath:attributes.indexPath];
            }else{
                attributes.zIndex = 0;
                attributes.frame = CGRectMake(0, attributes.frame.origin.y+(current_floor-1)*70+70*percent, CELL_WIDTH, CELL_HEIGHT);
                [self setEffectViewAlpha:0 forIndexPath:attributes.indexPath];
         
            }
            
            [self setImageViewOfItem:(screen_y-attributes.frame.origin.y)/568*IMAGEVIEW_MOVE_DISTANCE withIndexPath:attributes.indexPath];
            
        }
        
    }
    //解决第二格左图片文字坐标偏移
    else{
        
        for(UICollectionViewLayoutAttributes *attributes in array){
            
            if(attributes.indexPath.row > 1){
                [self setEffectViewAlpha:0 forIndexPath:attributes.indexPath];
            }
            //下滑时设置顶部背景图片视觉差效果
//            [self setImageViewOfItem:(screen_y-attributes.frame.origin.y)/568*IMAGEVIEW_MOVE_DISTANCE withIndexPath:attributes.indexPath];
            
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(setEffectOfHead:)]) [self.delegate setEffectOfHead:screen_y];
    
    return array;
}

/**
 *  设置CELL里imageView的位置偏移动画
 *
 *  @param distance
 *  @param indexpath
 */
-(void)setImageViewOfItem:(CGFloat)distance withIndexPath:(NSIndexPath *)indexpath
{
    GllCollectionViewCell *cell = (GllCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexpath];
    cell.imageView.frame = CGRectMake(0, IMAGEVIEW_ORIGIN_Y+distance, CELL_WIDTH, cell.imageView.frame.size.height);
    
    //更新最底部UIView坐标改变
    if (CGRectGetMinY(cell.frame) >= CELL_CURRHEIGHT && [self.delegate respondsToSelector:@selector(updateBotteomViewFrameWithMaxY:)])
        [self.delegate updateBotteomViewFrameWithMaxY:CGRectGetMaxY(cell.frame)];
    

}

-(void)setEffectViewAlpha:(CGFloat)percent forIndexPath:(NSIndexPath *)indexPath
{
    GllCollectionViewCell *cell = (GllCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    //遮罩透明度变化
    cell.maskView.alpha = (1-percent)*0.6;
    
    //单元格左图片的放大缩小动画
    cell.leftImageView.layer.transform = CATransform3DMakeScale(1+0.2*percent, 1+0.2*percent, 1);
    //重新定义左图片的Frame
    CGRect leftImageViewFrame = cell.leftImageView.frame;
    leftImageViewFrame.origin.y = CGRectGetHeight(cell.frame) - CGRectGetHeight(cell.leftImageView.frame) - (CELL_HEIGHT - CELL_WIDTH * 0.2) * 0.5;
    cell.leftImageView.frame = leftImageViewFrame;
    
    //标题动画
    cell.title.layer.transform = CATransform3DMakeScale(0.5+0.3*percent, 0.5+0.3*percent, 1);

    cell.title.frame = CGRectMake(CGRectGetMaxX(cell.leftImageView.frame) + 10, CGRectGetMinY(cell.leftImageView.frame) + (CGRectGetHeight(cell.leftImageView.frame) - CGRectGetHeight(cell.title.frame)) * 0.5 - percent*(CGRectGetHeight(cell.leftImageView.frame) - CGRectGetHeight(cell.title.frame)) * 0.4, cell.title.frame.size.width, cell.title.frame.size.height);
    
    cell.desc.frame = CGRectMake(CGRectGetMinX(cell.title.frame), CGRectGetMaxY(cell.leftImageView.frame) - CGRectGetHeight(cell.desc.frame), cell.desc.frame.size.width, cell.desc.frame.size.height);
    cell.desc.alpha = percent*0.85;
    
    
    
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    
    CGPoint destination;
    CGFloat positionY;
    CGFloat screen_y = self.collectionView.contentOffset.y;
    CGFloat cc;
    CGFloat count;
    if (screen_y < 0) {
        return proposedContentOffset;
    }
    if(velocity.y == 0){ //此情况可能由于拖拽不放手，停下时再放手的可能，所以加速度为0
        count = roundf(((proposedContentOffset.y-HEADER_HEIGHT)/DRAG_INTERVAL))+1;
        if(count == 0){
            positionY = 0;
        }else{
            positionY = HEADER_HEIGHT+(count-1)*DRAG_INTERVAL;
        }
    }else{
        //滑动速度调节
        if(velocity.y >1 && velocity.y < 3){
            cc = 1;
        }
        else if (velocity.y >= 3){
                cc = 2;
            }
        else if(velocity.y < -1){
            cc = -1;
        }else{
            cc = velocity.y;
        }
        if (velocity.y > 0) {
            count = ceilf(((screen_y + cc*DRAG_INTERVAL - HEADER_HEIGHT)/DRAG_INTERVAL))+1;
        }else{
            count = floorf(((screen_y + cc*DRAG_INTERVAL - HEADER_HEIGHT)/DRAG_INTERVAL))+1;
        }
        if(count == 0){
            positionY = 0;
        }else{
            positionY = HEADER_HEIGHT+(count-1)*DRAG_INTERVAL;
        }
        
    }
    
    if(positionY < 0){
        positionY = 0;
    }
    
//FIXME:解注释下面一行代码
    
//    if(positionY >= self.collectionView.contentSize.height - [UIScreen mainScreen].bounds.size.height - DRAG_INTERVAL + CELL_HEIGHT){
    
//FIXME:注释下面一行代码
        
    if(positionY > self.collectionView.contentSize.height - [UIScreen mainScreen].bounds.size.height){
        
        positionY = self.collectionView.contentSize.height - [UIScreen mainScreen].bounds.size.height;
    }
    
    destination = CGPointMake(0, positionY);
    self.collectionView.decelerationRate = .8;
    return destination;
}

-(void)dealloc
{
    
}

@end
