//
//  MyView.m
//  画图
//
//  Created by mj on 14-9-4.
//  Copyright (c) 2014年 Mr.Li. All rights reserved.
//

#import "PJRSignatureView.h"

@implementation MyViewModel

+ (id)viewModelWithColor:(UIColor *)color Path:(UIBezierPath *)path Width:(CGFloat)width
{
    MyViewModel *myViewModel = [[MyViewModel alloc] init];
    
    myViewModel.color = color;
    myViewModel.path = path;
    myViewModel.width = width;
    
    return myViewModel;
}
@end

@interface PJRSignatureView ()

@property (assign, nonatomic) CGMutablePathRef path;
@property (strong, nonatomic) NSMutableArray *pathArray;
@property (assign, nonatomic) BOOL isHavePath;
@end

@implementation PJRSignatureView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _lineWidth = 8.0f;
        _lineColor = [UIColor redColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self drawView:context];
}
- (void)drawView:(CGContextRef)context
{
    for (MyViewModel *myViewModel in _pathArray) {
        CGContextAddPath(context, myViewModel.path.CGPath);
        [myViewModel.color set];
        CGContextSetLineWidth(context, myViewModel.width);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextDrawPath(context, kCGPathStroke);
    }
    if (_isHavePath) {
        CGContextAddPath(context, _path);
        [_lineColor set];
        CGContextSetLineWidth(context, _lineWidth);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextDrawPath(context, kCGPathStroke);
    }
}

- (void)handleTouches:(NSSet *)touches
{
    if (self.drawingMode == DrawingModeNone) {
        // do nothing
    }
    else if (self.drawingMode == DrawingModePaint) {
        [self drawLineNew:(NSSet *)touches];
    }
    else
    {
        [self drawLineNew:(NSSet *)touches];
    }
}

- (void) drawLineNew:(NSSet *)touches
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    CGPathAddLineToPoint(_path, NULL, location.x, location.y);
    [self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location =[touch locationInView:self];
    _path = CGPathCreateMutable();
    _isHavePath = YES;
    CGPathMoveToPoint(_path, NULL, location.x, location.y);
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self handleTouches:(NSSet *)touches];
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.drawingMode == DrawingModeNone) {
        return;
    }
    
    if (_pathArray == nil) {
        _pathArray = [NSMutableArray array];
    }
    
    UIBezierPath *path = [UIBezierPath bezierPathWithCGPath:_path];
    MyViewModel *myViewModel = [MyViewModel viewModelWithColor:_lineColor Path:path Width:_lineWidth];
    [_pathArray addObject:myViewModel];
    
    CGPathRelease(_path);
    _isHavePath = NO;
}

- (void)clear
{
    [_pathArray removeAllObjects];
    [self setNeedsDisplay];
}
@end
