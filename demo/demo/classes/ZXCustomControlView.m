//
//  ZXCustomControlView.m
//  demo
//
//  Created by shaw on 15/7/25.
//  Copyright (c) 2015年 shaw. All rights reserved.
//-----------------自定义工具栏（播放，进度条等）-----------------------

#import "ZXCustomControlView.h"

#define kBaseTag 1000

@interface ZXCustomControlView ()

@property (weak, nonatomic) IBOutlet UIButton *playParseBtn;
@property (weak, nonatomic) IBOutlet UIButton *fullscreenBtn;
@property (weak, nonatomic) IBOutlet UISlider *progress;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic,assign) CGFloat currentTime;

@property (nonatomic,copy) void (^clickHandle)(NSInteger);
@property (nonatomic,copy) void (^slideHandle)(CGFloat,BOOL);

@end

@implementation ZXCustomControlView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [_playParseBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_playParseBtn setTag:kBaseTag + 1];
    [_fullscreenBtn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [_fullscreenBtn setTitle:@"全屏" forState:UIControlStateNormal];
    [_fullscreenBtn setTag:kBaseTag + 2];
    
    [_progress setValue:0];
    [_progress setTintColor:[UIColor redColor]];
    [_progress addTarget:self action:@selector(slideAction:) forControlEvents:UIControlEventValueChanged];
    [_progress addTarget:self action:@selector(moveEndAction:) forControlEvents:UIControlEventTouchUpInside];
    [_progress setTag:kBaseTag + 3];
    [_timeLabel setTextColor:[UIColor whiteColor]];
    [_timeLabel setTextAlignment:NSTextAlignmentRight];
    
    self.isControlEnable = NO;
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
}

-(void)setVideoDuration:(CGFloat)videoDuration
{
    _videoDuration = videoDuration;
    
    [self updateProgressText];
}

-(void)setIsPlaying:(BOOL)isPlaying
{
    _isPlaying = isPlaying;
    if(_isPlaying)
    {
        [_playParseBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    }
    else
    {
        [_playParseBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    }
}

-(void)setIsControlEnable:(BOOL)isControlEnable
{
    _isControlEnable = isControlEnable;
    
    [_playParseBtn setEnabled:_isControlEnable];
    [_fullscreenBtn setEnabled:_isControlEnable];
    [_progress setEnabled:_isControlEnable];
}

-(void)setCurrentTime:(CGFloat)currentTime
{
    if(_currentTime != currentTime)
    {
        _currentTime = currentTime;
        
        [self updateProgressText];
    }
}

-(void)setSlideValue:(CGFloat)value
{
    [_progress setValue:value animated:YES];
    
    self.currentTime = value * _videoDuration;
}

-(void)updateProgressText
{
    _timeLabel.text = [NSString stringWithFormat:@"%@ / %@",[self getTimeString:_currentTime],[self getTimeString:_videoDuration]];
}

-(NSString *)getTimeString:(CGFloat)timeInterval
{
    NSInteger hour = timeInterval / 3600.f;
    NSInteger minute = (timeInterval - hour * 3600.f) / 60.f;
    NSInteger second = timeInterval - hour * 3600.f - minute * 60.f;
    
    if(hour > 0)
    {
        return [NSString stringWithFormat:@"%ld:%02ld:%02ld",(long)hour,(long)minute,(long)second];
    }
    else
    {
        return [NSString stringWithFormat:@"%02ld:%02ld",(long)minute,(long)second];
    }
}

-(void)buttonAction:(UIButton *)sender
{
    NSInteger tag = sender.tag - kBaseTag;
    
    if(_clickHandle)
    {
        _clickHandle (tag);
    }
}

-(void)slideAction:(UISlider *)slider
{
    CGFloat progress = slider.value;
    
    CGFloat interval = progress * _videoDuration;
    self.currentTime = interval;
    
    if(_slideHandle)
    {
        _slideHandle(_currentTime,NO);
    }
}

-(void)moveEndAction:(UISlider *)slider
{
    CGFloat progress = slider.value;

    CGFloat interval = progress * _videoDuration;
    self.currentTime = interval;
    
    if(_slideHandle)
    {
        _slideHandle(_currentTime,YES);
    }
}

-(void)showWithClickHandle:(void (^)(NSInteger))clickHandle slideHandle:(void (^)(CGFloat,BOOL))slideHandle
{
    self.clickHandle = clickHandle;
    self.slideHandle = slideHandle;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
