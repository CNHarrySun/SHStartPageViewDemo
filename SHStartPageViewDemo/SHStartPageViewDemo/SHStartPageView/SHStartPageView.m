//
//  SHStartPageView.m
//  SHStartPageView
//
//  Created by CoderSun on 2017/3/28.
//  Copyright © 2017年 Mobby. All rights reserved.
//

#define MainScreen_width  [UIScreen mainScreen].bounds.size.width
#define MainScreen_height [UIScreen mainScreen].bounds.size.height

#import "SHStartPageView.h"
#import <AVFoundation/AVFoundation.h>

@interface SHStartPageView ()<UIScrollViewDelegate>

// image - SHStartPageView
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) UIScrollView *bigScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;


// video - SHStartPageView
@property (nonatomic, strong) UIView *videoView;
@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) NSURL *videoURL;


@end

@implementation SHStartPageView


- (instancetype)initWithImageArray:(NSArray *)imageArray
               enterButtonIsHidden:(BOOL)isHidden{
    
    if (self = [super initWithFrame:CGRectMake(0, 0, MainScreen_width, MainScreen_height)]) {
        
        _imageArray = imageArray;
        
        [self drawImageSHStartPageView:isHidden];
    }
    
    return self;
}


- (instancetype)initWithVideoName:(NSString *)videoName videoType:(NSString *)videoType enterButtonIsHidden:(BOOL)isHidden{
    
    
    NSString *pathString = [[NSBundle mainBundle] pathForResource:videoName ofType:videoType];
    NSURL *videoURL = [NSURL fileURLWithPath:pathString];

    return [self initWithVideoURL:videoURL enterButtonIsHidden:isHidden];
}



- (instancetype)initWithVideoURL:(NSURL *)videoURL enterButtonIsHidden:(BOOL)isHidden{
    
    if (self = [super initWithFrame:CGRectMake(0, 0, MainScreen_width, MainScreen_height)]) {
        
        self.videoURL = videoURL;
        [self drawVideoSHStartPageViewWithURL:self.videoURL isHidden:isHidden];
        
    }
    
    return self;
}

// 绘制视频启动图
- (void)drawVideoSHStartPageViewWithURL:(NSURL *)url isHidden:(BOOL)isHidden{
    
    self.videoView = [[UIView alloc] initWithFrame:self.frame];
    [self addSubview:self.videoView];
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    self.playerItem = playerItem;
    self.player = [AVPlayer playerWithPlayerItem:playerItem];
    
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    /*
     
     videoGravity：
     
        AVLayerVideoGravityResizeAspect：按原视频比例显示，是竖屏的就显示出竖屏的，两边留黑
        AVLayerVideoGravityResizeAspectFill：以原比例拉伸视频，直到两边屏幕都占满，但视频内容有部分就被切割了
        AVLayerVideoGravityResize：拉伸视频内容达到边框占满，但不按原比例拉伸，这里明显可以看出宽度被拉伸了
     
     */

    layer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self.videoView.layer addSublayer:layer];
    [self.player play];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayDidEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:playerItem];
    
    if (isHidden == NO) {
        
        UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        enterButton.frame = CGRectMake(self.videoView.frame.size.width / 2 - 50, MainScreen_height - 150, 100, 50);
        [enterButton setTitle:@"点击进入" forState:UIControlStateNormal];
        enterButton.layer.borderColor = [UIColor whiteColor].CGColor;
        enterButton.layer.borderWidth = 1;
        [enterButton addTarget:self action:@selector(skipAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.videoView addSubview:enterButton];
        [self.videoView bringSubviewToFront:enterButton];
    }
}


// 绘制图片启动图
- (void)drawImageSHStartPageView:(BOOL)isHidden{
    
    // scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, MainScreen_width, MainScreen_height)];
    scrollView.contentSize = CGSizeMake((_imageArray.count + 1) * MainScreen_width, MainScreen_height);
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    [self addSubview:scrollView];
    
    _bigScrollView = scrollView;
    
    // 添加引导图
    for (int i = 0; i < _imageArray.count; i ++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * MainScreen_width, 0, MainScreen_width, MainScreen_height)];
        imageView.image = [UIImage imageNamed:_imageArray[i]];
        imageView.userInteractionEnabled = YES;
        [scrollView addSubview:imageView];
        
        if (i == _imageArray.count - 1 && isHidden == NO) {
            
            // 点击进入按钮
            UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
            enterButton.frame = CGRectMake(imageView.frame.size.width/2 - 50, MainScreen_height - 150, 100, 50);
            [enterButton setTitle:@"点击进入" forState:UIControlStateNormal];
            enterButton.layer.borderColor = [UIColor whiteColor].CGColor;
            enterButton.layer.borderWidth = 1;
            [enterButton addTarget:self action:@selector(skipAction:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:enterButton];
        }else{
            
            // 跳过按钮
            UIButton *skipButton = [UIButton buttonWithType:UIButtonTypeCustom];
            skipButton.frame = CGRectMake(imageView.frame.size.width - 70, 20, 60, 30);
            [skipButton setTitle:@"跳过" forState:UIControlStateNormal];
            skipButton.titleLabel.font = [UIFont systemFontOfSize:20];
            [skipButton setTintColor:[UIColor lightGrayColor]];
            [skipButton setBackgroundColor:[UIColor grayColor]];
            [skipButton.layer setCornerRadius:5.0];
            [skipButton addTarget:self action:@selector(skipAction:) forControlEvents:UIControlEventTouchUpInside];
            [imageView addSubview:skipButton];
        }
    }
    
    // 页面控制器
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(MainScreen_width / 2, MainScreen_height - 60, 0, 40)];
    pageControl.numberOfPages = _imageArray.count;
    pageControl.backgroundColor = [UIColor clearColor];
    [self addSubview:pageControl];
    _pageControl = pageControl;
    
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == _bigScrollView) {
        
        CGPoint offset = scrollView.contentOffset;
        _pageControl.currentPage = offset.x / MainScreen_width;
    }
    
    if (scrollView.contentOffset.x == (_imageArray.count) * MainScreen_width) {
        
        [self removeFromSuperview];
    }
}


- (void)skipAction:(UIButton *)sender{
    
    if (self.player) {
        
        [self removePlayer];
    }
    [self removeFromSuperview];
}

- (void)removePlayer{
    
    [self.player pause];
    self.player = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - Notification
- (void)moviePlayDidEnd:(NSNotification *)notification{
    
    NSLog(@"播放完毕");
    
    if (self.player) {
        
        [self removePlayer];
    }
    [self removeFromSuperview];
}




@end
