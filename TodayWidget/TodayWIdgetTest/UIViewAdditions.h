//
//  UIViewAdditions.h
//  LaShouCommunity
//
//  Created by wanyueming on 09-11-27.
//  Copyright 2009 ___LASHOU-INC___. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface UIView (LSAdditional)

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat bottom;

@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;

@property(nonatomic,readonly) CGFloat screenX;
@property(nonatomic,readonly) CGFloat screenY;
@property(nonatomic,readonly) CGFloat screenViewX;
@property(nonatomic,readonly) CGFloat screenViewY;
@property(nonatomic,readonly) CGRect screenFrame;

@property(nonatomic,readonly) CGFloat orientationWidth;
@property(nonatomic,readonly) CGFloat orientationHeight;

@property (nonatomic, retain) NSObject *attachment; //在视图中附加一个绑定数据

- (void)removeSubviews;
- (CGPoint)centerOfFrame;
- (CGPoint)centerOfBounds;

+ (void)drawRoundRectangleInRect:(CGRect)rect withRadius:(CGFloat)radius color:(UIColor*)color;
/**
 *  画阴影
 *
 *  @param offset 偏移位置
 *  @param radius 弧度
 *  @param color  颜色
 */
- (void)drawShadowLayer:(CGSize)offset withRadius:(CGFloat)radius color:(UIColor*)color;
/**
 *  Description
 *
 *  @param startPoint
 *  @param endPoint
 *  @param color
 */
- (void)drawShadowLayerInRect:(CGRect)rect downward:(BOOL)downward;
/**
 *  画虚线
 *
 *  @param startPoint 开始位置
 *  @param endPoint   结束位置
 *  @param color      颜色
 */
- (void)drawDashLineFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint color:(UIColor *)color;

- (void)drawDashLineFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint color:(UIColor *)color lineWidth:(float)lineWidth lineDashPattern:(NSArray *)lineDashPattern;

/**
 *  画实线
 *
 *  @param startPoint 开始位置
 *  @param endPoint   结束位置
 *  @param color      颜色
 *  @param thickness  厚度
 */
- (void)drawSolidLineFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint color:(UIColor *)color thickness:(CGFloat)thickness;

/**
 *  划清晰直线
 *  @param rec 直线的frame
 *  @param color 颜色
 */
-(CAShapeLayer *)drawSolidLineWithFrame:(CGRect)rec color:(UIColor *)color;

- (UIImage *)captureFrame:(CGRect)r;

-(CAShapeLayer *)drawSolidLineWithFrame:(CGRect)rec;

@end
