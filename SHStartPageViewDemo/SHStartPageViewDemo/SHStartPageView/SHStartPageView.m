//
//  SHStartPageView.m
//  SHStartPageView
//
//  Created by HarrySun on 2017/3/28.
//  Copyright © 2017年 Mobby. All rights reserved.
//

#define MainScreen_width  [UIScreen mainScreen].bounds.size.width
#define MainScreen_height [UIScreen mainScreen].bounds.size.height

#import "SHStartPageView.h"

@interface SHStartPageView ()<UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) UIScrollView *bigScrollView;
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation SHStartPageView

- (instancetype)initWithFrame:(CGRect)frame
                   ImageArray:(NSArray *)imageArray
          enterButtonIsHidden:(BOOL)isHidden{
    
    if (self = [super initWithFrame:frame]) {
        
        _imageArray = imageArray;
        
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
    
    return self;
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
    
    [self removeFromSuperview];
}


@end
