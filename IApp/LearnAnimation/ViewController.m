//
//  ViewController.m
//  IApp
//
//  Created by CodeAm on 2020/10/15.
//  Copyright © 2020 codeam. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *layerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //create sublayer
    _layerView = [[UIView alloc] initWithFrame:self.view.frame];
    _layerView.backgroundColor = [UIColor grayColor];
    //[self learnCustomDrawing];
    //[self setupCombinationPicture];
    //[self learnContentsCenter];
    //[self learnShadow];
    //[self learnMask];
    [self learnGroupAlpha];
    self.view = _layerView;
}

- (void)learnCustomDrawing {
    CALayer *blueLayer = [CALayer layer];
    blueLayer.frame = CGRectMake(50.0f, 100, 100.0f, 100.0f);
    blueLayer.backgroundColor = [UIColor blueColor].CGColor;
    blueLayer.delegate = self;
    blueLayer.contentsScale = [UIScreen mainScreen].scale;
    [_layerView.layer addSublayer:blueLayer];
    
    [blueLayer display];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    CGContextSetLineWidth(ctx, 10.0f);
    CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
    CGContextStrokeEllipseInRect(ctx, layer.bounds);
}

- (void)setupCombinationPicture {
    UIImage *image = [UIImage imageNamed:@"p_5"];
    
    CALayer *top_left = [CALayer layer];
    top_left.frame = CGRectMake(0, 100, 50, 50);
    top_left.contents = (__bridge id)image.CGImage;
    top_left.contentsGravity = kCAGravityResizeAspect;
    top_left.contentsRect = CGRectMake(0, 0, 0.5, 0.5);
    [_layerView.layer addSublayer:top_left];
    
    CALayer *top_right = [CALayer layer];
    top_right.frame = CGRectMake(0, 150, 50, 50);
    top_right.contents = (__bridge id)image.CGImage;
    top_right.contentsGravity = kCAGravityResizeAspect;
    top_right.contentsRect = CGRectMake(0.5, 0, 0.5, 1);
    [_layerView.layer addSublayer:top_right];
    
    CALayer *bottom_left = [CALayer layer];
    bottom_left.frame = CGRectMake(0, 200, 50, 50);
    bottom_left.contents = (__bridge id)image.CGImage;
    bottom_left.contentsGravity = kCAGravityResizeAspect;
    bottom_left.contentsRect = CGRectMake(0, 0.5, 0.5, 1);
    [_layerView.layer addSublayer:bottom_left];
    
    CALayer *bottom_right = [CALayer layer];
    bottom_right.frame = CGRectMake(0, 250, 50, 50);
    bottom_right.contents = (__bridge id)image.CGImage;
    bottom_right.contentsGravity = kCAGravityResizeAspect;
    bottom_right.contentsRect = CGRectMake(0.5, 1, 1, 1);
    [_layerView.layer addSublayer:bottom_right];
}

- (void)learnContentsCenter {
    UIImage *image = [UIImage imageNamed:@"img_1"];
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 100, 400, 400);
    layer.contents = (__bridge id)image.CGImage;
    layer.contentsCenter = CGRectMake(0.5, 0.5, 1, 1);
    [_layerView.layer addSublayer:layer];
}

-(void)learnShadow {
    UIImage *image = [UIImage imageNamed:@"img_1"];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(50, 100, 200, 200);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    layer.cornerRadius = 20.f;
    
    CALayer *shawdowLayer = [CALayer layer];
    shawdowLayer.frame = CGRectMake(50, 50, 50, 50);
    shawdowLayer.cornerRadius = 25.0;
    shawdowLayer.contents = (__bridge id)image.CGImage;
    shawdowLayer.contentsGravity = kCAGravityResizeAspect;
    //shawdowLayer.masksToBounds = YES; 裁剪后会影响阴影的显示
    //shawdowLayer.shadowPath 制定任意的阴影形状
    shawdowLayer.backgroundColor = [UIColor redColor].CGColor;
    shawdowLayer.shadowOpacity = 1;
    shawdowLayer.shadowColor = [UIColor blueColor].CGColor;
    shawdowLayer.shadowOffset = CGSizeMake(10, 10);
    
    
    [layer addSublayer: shawdowLayer];
    
    [_layerView.layer addSublayer: layer];
}

- (void)learnMask {
    UIImage *image = [UIImage imageNamed:@"img_1"];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(50, 100, 200, 200);
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    layer.contents = (__bridge id)image.CGImage;
    layer.contentsGravity = kCAGravityResizeAspect;
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.frame = CGRectMake(60, 110, 100, 100);
    maskLayer.cornerRadius = 50.0;
    maskLayer.backgroundColor = [UIColor colorWithWhite:1 alpha:1].CGColor;

    layer.mask = maskLayer;
    
    [_layerView.layer addSublayer: layer];
}

- (void)learnGroupAlpha {
    //create opaque button
    UIButton *button1 = [self customButton];
    button1.center = CGPointMake(50, 150);
    [_layerView addSubview:button1];
    
    //create translucent button
    UIButton *button2 = [self customButton];
    button2.center = CGPointMake(250, 150);
    button2.alpha = 0.5;
    [_layerView addSubview:button2];
    
    //enable rasterization for the translucent button
    button2.layer.shouldRasterize = YES;
    button2.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

- (UIButton *)customButton
{
  //create button
  CGRect frame = CGRectMake(0, 0, 150, 50);
  UIButton *button = [[UIButton alloc] initWithFrame:frame];
  button.backgroundColor = [UIColor whiteColor];
  button.layer.cornerRadius = 10;

  //add label
  frame = CGRectMake(20, 10, 110, 30);
  UILabel *label = [[UILabel alloc] initWithFrame:frame];
  label.text = @"Hello World";
  label.textAlignment = NSTextAlignmentCenter;
  [button addSubview:label];
  return button;
}

@end
