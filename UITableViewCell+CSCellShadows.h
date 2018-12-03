//
//  UITableViewCell+CSCellShadows.h
//  CoinShang
//
//  Created by Jiayu_iOSer on 2018/11/27.
//  Copyright © 2018 Shangbee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewCell (CSCellShadows)

/*
 / 给tableview section 添加圆角
 /
 */
- (void)addShadowToSectionTableView:(UITableView *)tableView
                        atIndexPath:(NSIndexPath *)indexPath;

/** adds a drop shadow to the background view of the (grouped) cell */
- (void)addShadowToCellInTableView:(UITableView *)tableView
                       atIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
