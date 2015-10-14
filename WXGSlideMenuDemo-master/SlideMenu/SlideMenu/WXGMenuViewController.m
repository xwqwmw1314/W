//
//  WXGMenuViewController.m
//  SlideMenu
//
//  Created by Nicholas Chow on 15/7/5.
//  Copyright (c) 2015年 Nicholas Chow. All rights reserved.
//

#import "WXGMenuViewController.h"
#import "WXGMenuCell.h"
#import "WXGMenuItem.h"

@interface WXGMenuViewController ()

@property (nonatomic, copy) NSArray *menuItems;

@end

@implementation WXGMenuViewController

// 加载plist文件数据并转换为模型数组
- (NSArray *)menuItems {
    if (!_menuItems) {
        NSArray *dicts = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MenuItems" ofType:@"plist"]];
        NSMutableArray *array = @[].mutableCopy;
        for (NSDictionary *dict in dicts) {
            WXGMenuItem *item = [WXGMenuItem itemWithDict:dict];
            [array addObject:item];
        }
        _menuItems = array.copy;
    }
    return _menuItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 默认选中菜单第一行，第一次选中时不做动画
    self.menuDidClick(self.menuItems[0], YES);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WXGMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WXGMenuCell class]) forIndexPath:indexPath];
    cell.item = self.menuItems[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return MAX(80, CGRectGetHeight(self.tableView.bounds) / self.menuItems.count);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.menuDidClick) {
        self.menuDidClick(self.menuItems[indexPath.row], NO);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
