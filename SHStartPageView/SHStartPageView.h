//
//  SHStartPageView.h
//  SHStartPageView
//
//  Created by HarrySun on 2017/3/28.
//  Copyright © 2017年 Mobby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHStartPageView : UIView

/**
 Create SHStartPageView

 @param frame frame
 @param imageArray 引导页图片数组
 @param isHidden 点击进入按钮是否隐藏
 @return SHStartPageView
 */
- (instancetype)initWithFrame:(CGRect)frame
                   ImageArray:(NSArray *)imageArray
          enterButtonIsHidden:(BOOL)isHidden;

@end
