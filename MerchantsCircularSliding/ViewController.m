//
//  ViewController.m
//  MerchantsCircularSliding
//
//  Created by 淘卡淘 on 16/9/12.
//  Copyright © 2016年 taokatao. All rights reserved.
//

#import "ViewController.h"
#import "GllMainCell.h"
#import "GllCollectionViewCell.h"
#import "GllCollectionViewFlowLayout.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,GllMainCellDelegate,GllCollectionViewFlowLayoutDelegate>

{
    NSArray                             *_allSectionCardTitles;
    UITableView                     *_cardsTableView;
    UICollectionView            *gllCollectionView;
    UIView                                *backView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _allSectionCardTitles = [NSArray arrayWithObjects:@"卡蜜",@"淘卡淘",@"净网大师",@"数字的尾巴",@"预见",@"时尚男装",@"滑县",@"牛屯",@"公司", nil];
    
    [self initCollectionView];
    
}

-(void)initCollectionView
{
    GllCollectionViewFlowLayout *layout = [[GllCollectionViewFlowLayout alloc] init];
    layout.delegate = self;
    [layout setContentSize:_allSectionCardTitles.count];
    gllCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds)) collectionViewLayout:layout];
    gllCollectionView.backgroundColor = [UIColor orangeColor];
    [gllCollectionView registerClass:[GllCollectionViewCell class] forCellWithReuseIdentifier:@"myCell"];
    gllCollectionView.delegate = self;
    gllCollectionView.dataSource = self;
    [self.view addSubview:gllCollectionView];
    
    //底部显示没有更多的UIView控件
    backView = [[UIView alloc] initWithFrame:CGRectMake(0, layout.collectionViewContentSize.height - SC_IMAGEVIEW_HEIGHT + 32, CELL_WIDTH, SC_IMAGEVIEW_HEIGHT - 32)];
    backView.backgroundColor = [UIColor clearColor];
    [gllCollectionView addSubview:backView];
    
    //此处可以放置任意数据加载完成之后的信息
    //如果位置嫌小，可以把最上面那个CELL顶到最上面不显示，这个界面显示数据加载完成之后的信息
    //如果你要这么做，你可以在GllCollectionViewFlowLayout中搜索FIXME来修改相应代码，记得把backView的高设置为全屏CGRectGetHeight([UIScreen mainScreen].bounds)
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CELL_WIDTH, TITLE_HEIGHT)];
    titleLable.text = @"No More Data";
    titleLable.textColor = [UIColor whiteColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
    [backView addSubview:titleLable];
}

- (void)updateBotteomViewFrameWithMaxY:(CGFloat)MaxY
{
    CGRect rect = backView.frame;
    rect.origin.y = MaxY;
    backView.frame = rect;
}

#pragma -mark UICollectionView 代理方法

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _allSectionCardTitles.count + 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        return CGSizeMake(CELL_WIDTH, 0);
    }else if(indexPath.row == 1){
        return CGSizeMake(CELL_WIDTH, CELL_CURRHEIGHT);
    }else{
        return CGSizeMake(CELL_WIDTH, CELL_HEIGHT);
    }
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

#pragma mark - cellForItemAtIndexPath
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GllCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    cell.delegate = self;
    cell.tag = indexPath.row;
    [cell setIndex:indexPath.row];
    [cell reset];
    
    if (indexPath.row == 0) {
        
    } else {
        
        if(indexPath.row == 1){
            [cell revisePositionAtFirstCell];
        }
        
        UIImage *image = [UIImage imageNamed:@"LOGO60"];
        cell.imageView.image = image;
        
        cell.leftImageView.image = [UIImage imageNamed:@"LOGO60"];
        cell.title.text = [_allSectionCardTitles objectAtIndex:indexPath.row - 1];
        cell.desc.text = @"卡蜜，一个会员卡管理的专业平台。";
        
        switch (indexPath.row % 7) {
                
            case 0:
                [cell.maskView setBackgroundColor:[UIColor purpleColor]];
                break;
            case 1:
                [cell.maskView setBackgroundColor:[UIColor redColor]];
                break;
            case 2:
                [cell.maskView setBackgroundColor:[UIColor orangeColor]];
                break;
            case 3:
                [cell.maskView setBackgroundColor:[UIColor yellowColor]];
                break;
            case 4:
                [cell.maskView setBackgroundColor:[UIColor greenColor]];
                break;
            case 5:
                [cell.maskView setBackgroundColor:[UIColor cyanColor]];
                break;
            case 6:
                [cell.maskView setBackgroundColor:[UIColor blueColor]];
                
        }
        
        
    }
    return cell;
}

#pragma mark - 商品点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GllCollectionViewCell *cell = (GllCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    NSLog(@"------%@-------",cell.title.text);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
