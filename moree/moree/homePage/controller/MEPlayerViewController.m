//
//  MEPlayerViewController.m
//  moree
//
//  Created by moyi on 2019/7/10.
//  Copyright © 2019 moreecare. All rights reserved.
//

#import "MEPlayerViewController.h"
//#import "MEVideoPlayer.h"
@interface MEPlayerViewController ()

@end

@implementation MEPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self performSelectorOnMainThread:@selector(play) withObject:nil waitUntilDone:NO];
}
- (void)play
{
//    [[MEVideoPlayer sharedInstance] playWithUrl:[NSURL URLWithString:@"https://gcs-vimeo.akamaized.net/exp=1562751480~acl=%2A%2F623685558.mp4%2A~hmac=706057415cce4db6ab076d278013f158f000c8220ae897c63fe66ae61f819800/vimeo-prod-skyfire-std-us/01/2670/7/188350983/623685558.mp4"] showView:self.view];
//    AVPlayerLayer * layer = [MEVideoPlayer sharedInstance].currentPlayerLayer;
//    layer.frame = self.view.bounds;
//    [self.view.layer insertSublayer:layer atIndex:0];
}

@end
