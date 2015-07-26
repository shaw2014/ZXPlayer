//
//  ZXCustomControlView.h
//  demo
//
//  Created by shaw on 15/7/25.
//  Copyright (c) 2015年 shaw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXCustomControlView : UIView

@property (nonatomic,assign) CGFloat videoDuration;
@property (nonatomic,assign) BOOL isPlaying;
@property (nonatomic,assign) BOOL isControlEnable;

-(void)showWithClickHandle:(void (^)(NSInteger tag))clickHandle slideHandle:(void (^)(CGFloat interval,BOOL isFinished))slideHandle;

-(void)setSlideValue:(CGFloat)value;

@end
