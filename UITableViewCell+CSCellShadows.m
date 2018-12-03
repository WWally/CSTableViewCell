//
//  UITableViewCell+CSCellShadows.m
//  CoinShang
//
//  Created by Jiayu_iOSer on 2018/11/27.
//  Copyright © 2018 Shangbee. All rights reserved.
//

#import "UITableViewCell+CSCellShadows.h"

@implementation UITableViewCell (CSCellShadows)

- (void)addShadowToCellInTableView:(UITableView *)tableView
                       atIndexPath:(NSIndexPath *)indexPath
{
    
    // 给section加阴影
    BOOL isFirstRow = !indexPath.row;// 第一个cell
    BOOL isLastRow = (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1);//最后一个cell
    BOOL isSectionOneRow = ([tableView numberOfRowsInSection:indexPath.section] == 1);// 只有一个cell
    
    // the shadow rect determines the area in which the shadow gets drawn
    CGRect shadowRect = CGRectInset(CGRectMake(0, 0, kScreen_Width, self.frame.size.height), 20, -10);
    if(isFirstRow)
       shadowRect.origin.y += 10;
    else if(isLastRow)
        shadowRect.size.height -= 10;


    
    // the mask rect ensures that the shadow doesn't bleed into other table cells
    CGRect maskRect = CGRectInset(CGRectMake(0, 0, kScreen_Width, self.frame.size.height), -20, 0);
    if(isFirstRow) {
        maskRect.origin.y -= 10;
        maskRect.size.height += 10;
    }
    else if(isLastRow)
        maskRect.size.height += 10;
    
    
    // 如果section 只有一个cell
    if (isSectionOneRow) {
        for (int i = 0; i < 2; i++) {
        shadowRect.size.height -= 10;
        maskRect.size.height += 2.5;
        }
        
    }
    
    
    
    
    // now configure the background view layer with the shadow
    CALayer *layers = self.backgroundView.layer;
    layers.shadowColor = SecondTextColor.CGColor;
    layers.shadowOffset = CGSizeMake(0, 0);
    layers.shadowRadius = 2.5;
    layers.shadowOpacity = 0.2f;
    layers.shadowPath = [UIBezierPath bezierPathWithRoundedRect:shadowRect cornerRadius:5].CGPath;
    layers.masksToBounds = NO;
    
    // and finally add the shadow mask
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRect:maskRect].CGPath;
    layers.mask = maskLayer;
    
    
    /*
    BOOL isFirstRow = !indexPath.row;
    BOOL isLastRow = (indexPath.row == [tableView numberOfRowsInSection:indexPath.section] - 1);
    
    // the shadow rect determines the area in which the shadow gets drawn
    CGRect shadowRect = CGRectInset(self.backgroundView.bounds, 0, -10);
    if(isFirstRow)
        shadowRect.origin.y += 10;
    else if(isLastRow)
        shadowRect.size.height -= 10;
    
    // the mask rect ensures that the shadow doesn't bleed into other table cells
    CGRect maskRect = CGRectInset(self.backgroundView.bounds, -20, 0);
    if(isFirstRow) {
        maskRect.origin.y -= 10;
        maskRect.size.height += 10;
    }
    else if(isLastRow)
        maskRect.size.height += 10;
    
    // now configure the background view layer with the shadow
    CALayer *layer = self.backgroundView.layer;
    layer.shadowColor = [UIColor redColor].CGColor;
    layer.shadowOffset = CGSizeMake(0, 0);
    layer.shadowRadius = 3;
    layer.shadowOpacity = 0.75;
    layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:shadowRect cornerRadius:5].CGPath;
    layer.masksToBounds = NO;
    
    // and finally add the shadow mask
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = [UIBezierPath bezierPathWithRect:maskRect].CGPath;
    layer.mask = maskLayer;
     
     */
}

/*
 / 给tableview section 添加圆角
 /
 */
- (void)addShadowToSectionTableView:(UITableView *)tableView
                        atIndexPath:(NSIndexPath *)indexPath{
    
    // 圆角弧度半径
    CGFloat cornerRadius = 5.f;
    // 设置cell的背景色为透明，如果不设置这个的话，则原来的背景色不会被覆盖
    self.backgroundColor = UIColor.clearColor;
    
    // 创建一个shapeLayer
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    CAShapeLayer *backgroundLayer = [[CAShapeLayer alloc] init]; //显示选中
    // 创建一个可变的图像Path句柄，该路径用于保存绘图信息
    CGMutablePathRef pathRef = CGPathCreateMutable();
    // 获取cell的size
    // 第一个参数,是整个 cell 的 bounds, 第二个参数是距左右两端的距离,第三个参数是距上下两端的距离
    CGRect bounds = CGRectInset(self.bounds, 20, 0);
    // CGRectGetMinY：返回对象顶点坐标
    // CGRectGetMaxY：返回对象底点坐标
    // CGRectGetMinX：返回对象左边缘坐标
    // CGRectGetMaxX：返回对象右边缘坐标
    // CGRectGetMidX: 返回对象中心点的X坐标
    // CGRectGetMidY: 返回对象中心点的Y坐标
    
    // 这里要判断分组列表中的第一行，每组section的第一行，每组section的中间行
    
    // CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
    
    // 起始坐标为左下角，设为p，（CGRectGetMinX(bounds), CGRectGetMinY(bounds)）为左上角的点，设为p1(x1,y1)，(CGRectGetMidX(bounds), CGRectGetMinY(bounds))为顶部中点的点，设为p2(x2,y2)。然后连接p1和p2为一条直线l1，连接初始点p到p1成一条直线l，则在两条直线相交处绘制弧度为r的圆角。
    
    if (indexPath.row == 0) {
        if ([tableView numberOfRowsInSection:indexPath.section] == 1) {
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMinX(bounds), CGRectGetMidY(bounds), cornerRadius);
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            
        }else{
            // 初始起点为cell的左下角坐标
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            // 终点坐标为右下角坐标点，把绘图信息都放到路径中去,根据这些路径就构成了一块区域了
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
        }
    } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
        // 初始起点为cell的左上角坐标
        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
        // 添加一条直线，终点坐标为右下角坐标点并放到路径中去
        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
    }else {
        
        // 添加cell的rectangle信息到path中（不包括圆角）
        CGPathAddRect(pathRef, nil, bounds);
    }
    
    
    // 把已经绘制好的可变图像路径赋值给图层，然后图层根据这图像path进行图像渲染render
    layer.path = pathRef;
    backgroundLayer.path = pathRef;
    // 注意：但凡通过Quartz2D中带有creat/copy/retain方法创建出来的值都必须要释放
    CFRelease(pathRef);
    // 按照shape layer的path填充颜色，类似于渲染render
    // layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
    layer.fillColor = [UIColor whiteColor].CGColor;
    
    
    
    // view大小与cell一致
    UIView *roundView = [[UIView alloc] initWithFrame:bounds];
    // 添加自定义圆角后的图层到roundView中
    [roundView.layer insertSublayer:layer atIndex:0];
    roundView.backgroundColor = UIColor.clearColor;
    // cell的背景view
    self.backgroundView = roundView;
}
@end
