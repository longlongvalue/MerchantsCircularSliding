//
//  GllMainCell.h
//  TaoKaTaoCardPackage
//
//  Created by 淘卡淘 on 16/9/8.
//  Copyright © 2016年 taokatao. All rights reserved.
//

#ifndef GllMainCell_h
#define GllMainCell_h

//普通高度
#define CELL_HEIGHT 100
//左边图片高宽
#define CELL_LEFTIMAGEWH 60
//宽度
#define CELL_WIDTH [UIScreen mainScreen].bounds.size.width
//高度
#define CELL_HIGHT [UIScreen mainScreen].bounds.size.height
//置顶高度
#define CELL_CURRHEIGHT 240
//标题高度
#define TITLE_HEIGHT 30
//标题缩放比例
#define TITLE_SCALE 0.5
//标题与左图片间隔
#define TITLE_MARGINX 10
//背景图片y
#define IMAGEVIEW_ORIGIN_Y -50
//背景图片滑动距离
#define IMAGEVIEW_MOVE_DISTANCE 160
//背景图片高
#define SC_IMAGEVIEW_HEIGHT 360
//每个cell的在顶部隐藏时高度
#define DRAG_INTERVAL 170.0f
#define HEADER_HEIGHT 0.0f
#define RECT_RANGE CELL_HIGHT * 2

#endif /* GllMainCell_h */
