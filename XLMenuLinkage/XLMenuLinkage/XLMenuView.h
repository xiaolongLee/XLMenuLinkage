//
//  XLMenuView.h
//  XLMenuLinkage
//
//  Created by Mac-Qke on 2018/12/20.
//  Copyright © 2018 Mac-Qke. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//点击菜单的回调方法
typedef void(^SelectColumnBlock)(NSInteger index);

@interface XLMenuView : UIView <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *menuView; // 菜单列表
@property (nonatomic, strong) UIView *showLineView;  // 当前菜单指示条
@property (nonatomic, assign) BOOL showLineAnimate;
@property (nonatomic, assign) NSInteger currentPageNumber; // 当前页码
//分割线
@property (nonatomic, strong) UIView *segmentLine;

@property (nonatomic, strong) NSMutableArray *menuArray;
@property (nonatomic, strong) NSMutableArray *columnLabelArray;

@property (nonatomic, copy) SelectColumnBlock selectColumnBlock;

//菜单字体的颜色大小
@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIFont *currentFont;
@property (nonatomic, strong) UIFont *normalFont;

//创建菜单
- (void)createColumnMenuView;

// 调整菜单条的contengOffset
- (void)adjustMenuViewContentOffsetWithPageNumber:(NSInteger)index animate:(BOOL)isAnimate;

////指示条动画 根据视图外ScrollView的偏移量来计算指示条的位置
//- (void)showLineViewAnimate:(CGFloat)contentOffsetX;
//指示条动画 根据视图外ScrollView的偏移量和方向来动画的显示指示条的位置
- (void)showLineViewAnimate:(CGFloat)contentOffsetX direction:(NSString *)direction;

@end

NS_ASSUME_NONNULL_END
