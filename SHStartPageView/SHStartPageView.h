//
//  SHStartPageView.h
//  SHStartPageView
//
//  Created by CoderSun on 2017/3/28.
//  Copyright © 2017年 Mobby. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHStartPageView : UIView

/**
 根据图片数组创建SHStartPageView

 @param imageArray 引导页图片数组
 @param isHidden 点击进入按钮是否隐藏
 @return SHStartPageView
 */
- (instancetype)initWithImageArray:(NSArray *)imageArray
               enterButtonIsHidden:(BOOL)isHidden;




/**
 根据视频名称以及视频类型创建SHStartPageView

 @param videoName 视频名称
 @param videoType 视频格式
 @param isHidden 点击进入按钮是否隐藏
 @return SHStartPageView
 */
- (instancetype)initWithVideoName:(NSString *)videoName
                        videoType:(NSString *)videoType
              enterButtonIsHidden:(BOOL)isHidden;


/**
 根据视频url创建SHStartPageView

 @param videoURL 视频url
 @param isHidden 点击进入按钮是否隐藏
 @return SHStartPageView
 */
- (instancetype)initWithVideoURL:(NSURL *)videoURL
             enterButtonIsHidden:(BOOL)isHidden;

@end
