//
//  ZXVideoView.h
//  demo
//
//  Created by shaw on 15/7/25.
//  Copyright (c) 2015年 shaw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ZXVideoView : UIView

@property (nonatomic,strong) AVPlayer *player;

-(void)setFillMode:(NSString *)fillMode;

@end
