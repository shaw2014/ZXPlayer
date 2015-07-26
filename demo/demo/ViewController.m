//
//  ViewController.m
//  demo
//
//  Created by shaw on 15/7/26.
//  Copyright (c) 2015年 shaw. All rights reserved.
//

#import "ViewController.h"
#import "ZXVideoPlayerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 40);
    [btn setTitle:@"show" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)show:(UIButton *)sender
{
    
    ZXVideoPlayerViewController *videoVC = [[ZXVideoPlayerViewController alloc]init];
    [self presentViewController:videoVC animated:YES completion:nil];
    videoVC.videoUrl = @"http://v.iseeyoo.cn/video/2010/10/25/2a9f0f4e-e035-11df-9117-001e0bbb2442_001.mp4";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
