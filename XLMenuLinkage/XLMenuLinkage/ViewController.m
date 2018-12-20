//
//  ViewController.m
//  XLMenuLinkage
//
//  Created by Mac-Qke on 2018/12/20.
//  Copyright © 2018 Mac-Qke. All rights reserved.
//

#import "ViewController.h"
#import "PrefixHeader.pch"
#import "XLMenuView.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) XLMenuView *menuView;

@property (nonatomic, strong) UITableView *tableView;

//是否是拖拽
@property (nonatomic, assign) BOOL isDrag;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.menuView];
    [self.view addSubview:self.tableView];
}


#pragma mark -- Getter

- (XLMenuView *)menuView {
    if (_menuView == nil) {
        _menuView = [[XLMenuView alloc] initWithFrame:CGRectMake(0, StatusBarHeight, SCREEN_WIDTH, StatusBarAndNavigationBarHeight -StatusBarHeight)];
        _menuView.backgroundColor = [UIColor whiteColor];
        _menuView.currentFont   = [UIFont systemFontOfSize:20];
        _menuView.normalFont = [UIFont systemFontOfSize:15];
        _menuView.currentColor   = RGBRANDOMCOLOR;
        _menuView.normalColor = RGBRANDOMCOLOR;
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < 20; i++) {
            [array addObject:[NSString stringWithFormat:@"第%d组",i]];
            
        }
        
        _menuView.menuArray = array;
        __weak typeof(self) weakSelf = self;
        _menuView.selectColumnBlock = ^(NSInteger index) {
            if (index < array.count) {
                [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            }
        };
    }
    
    
    return _menuView;
}


- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, StatusBarAndNavigationBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - StatusBarAndNavigationBarHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    
    
    return _tableView;
}


#pragma mark -- UITableViewDelegate UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    label.textAlignment  = NSTextAlignmentCenter;
    label.textColor  = [UIColor blueColor];
    label.text = [NSString stringWithFormat:@"第%ld组",section];
    return label;
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    return 0.1;
}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellID"];
        
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld组内的商品",(long)indexPath.section];
    return cell;
}

#pragma mark --- UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:CGPointMake(0, scrollView.contentOffset.y + 1)];
    [self.menuView adjustMenuViewContentOffsetWithPageNumber:indexPath.section animate:_isDrag];
    
    NSLog(@"滑到了第 %ld",indexPath.section);
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _isDrag = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate == NO) {
        _isDrag = NO;
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    _isDrag = NO;
}

@end
