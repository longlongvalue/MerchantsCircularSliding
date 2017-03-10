//
//  ViewController.m
//  MerchantsCircularSliding
//
//  Created by 淘卡淘 on 16/9/12.
//  Copyright © 2016年 taokatao. All rights reserved.
//

#import "ViewController.h"

#import "CellInfoDataModel.h"

#import "GllMainCell.h"
#import "GllCollectionViewCell.h"
#import "GllCollectionViewFlowLayout.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,GllMainCellDelegate,GllCollectionViewFlowLayoutDelegate>

{
    UICollectionView            *gllCollectionView;
    UIView                                *backView;
}

@property (nonatomic ,strong) NSMutableArray *cardModelsM;

@end

@implementation ViewController

- (NSMutableArray *)cardModelsM
{
    if (!_cardModelsM) {
        _cardModelsM = [NSMutableArray arrayWithCapacity:0];
    }
    return _cardModelsM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化数据
    [self initData];
    
    //布局控件
    [self initCollectionView];
    
}

- (void)initData
{
    NSDictionary *dict1= [NSDictionary dictionaryWithObjectsAndKeys:@"10 Free 4 X 6 Prints", @"title",@"Online Code", @"subTitle",@"ab", @"leftImageNameStr",@"a", @"backImageNameStr",nil];
    
    CellInfoDataModel *cellModel1 = [[CellInfoDataModel alloc] initWithDict:dict1];
    
    NSDictionary *dict2= [NSDictionary dictionaryWithObjectsAndKeys:@"$20 Off $85+", @"title",@"In-Store & Online", @"subTitle",@"aa", @"leftImageNameStr",@"a", @"backImageNameStr",nil];
    
    CellInfoDataModel *cellModel2 = [[CellInfoDataModel alloc] initWithDict:dict2];
    
    NSDictionary *dict3= [NSDictionary dictionaryWithObjectsAndKeys:@"$30 Off $90", @"title",@"Online Code", @"subTitle",@"ab", @"leftImageNameStr",@"a", @"backImageNameStr",nil];
    
    CellInfoDataModel *cellModel3 = [[CellInfoDataModel alloc] initWithDict:dict3];
    
    NSDictionary *dict4= [NSDictionary dictionaryWithObjectsAndKeys:@"Free Lip Gloss on $15+", @"title",@"Online Code", @"subTitle",@"aa", @"leftImageNameStr",@"a", @"backImageNameStr",nil];
    
    CellInfoDataModel *cellModel4 = [[CellInfoDataModel alloc] initWithDict:dict4];
    
    NSDictionary *dict5= [NSDictionary dictionaryWithObjectsAndKeys:@"30% Off Select Prices", @"title",@"Online Sale", @"subTitle",@"ab", @"leftImageNameStr",@"a", @"backImageNameStr",nil];
    
    CellInfoDataModel *cellModel5 = [[CellInfoDataModel alloc] initWithDict:dict5];
    
    NSDictionary *dict6= [NSDictionary dictionaryWithObjectsAndKeys:@"Up to 70% Off", @"title",@"Labor Day Online Sale", @"subTitle",@"aa", @"leftImageNameStr",@"a", @"backImageNameStr",nil];
    
    CellInfoDataModel *cellModel6 = [[CellInfoDataModel alloc] initWithDict:dict6];
    
    NSDictionary *dict7= [NSDictionary dictionaryWithObjectsAndKeys:@"Play to Win Up to $50", @"title",@"You could even win $5k!", @"subTitle",@"ab", @"leftImageNameStr",@"a", @"backImageNameStr",nil];
    
    CellInfoDataModel *cellModel7 = [[CellInfoDataModel alloc] initWithDict:dict7];
    
    NSDictionary *dict8= [NSDictionary dictionaryWithObjectsAndKeys:@"Fares from $39 One Way", @"title",@"Hot 2 Day Sale", @"subTitle",@"aa", @"leftImageNameStr",@"a", @"backImageNameStr",nil];
    
    CellInfoDataModel *cellModel8 = [[CellInfoDataModel alloc] initWithDict:dict8];
    
    [self.cardModelsM addObjectsFromArray:[NSArray arrayWithObjects:cellModel1,cellModel2,cellModel3,cellModel4,cellModel5,cellModel6,cellModel7,cellModel8, nil]];
    
    
}

-(void)initCollectionView
{
    GllCollectionViewFlowLayout *layout = [[GllCollectionViewFlowLayout alloc] init];
    layout.delegate = self;
    [layout setContentSize:self.cardModelsM.count];
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
    return self.cardModelsM.count + 1;
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
        
        CellInfoDataModel *cellModel = [self.cardModelsM objectAtIndex:indexPath.row - 1];
        
        UIImage *image = [UIImage imageNamed:cellModel.backImageNameStr];
        cell.imageView.image = image;
        
        cell.leftImageView.image = [UIImage imageNamed:cellModel.leftImageNameStr];
        cell.title.text = cellModel.title;
        cell.desc.text = cellModel.subTitle;
        
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
