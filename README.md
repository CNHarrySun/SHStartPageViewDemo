# SHStartPageView
## 一键集成引导页


## 3.30 加入视频引导图

### 效果图：

![视频启动图](http://oixwuce1i.bkt.clouddn.com/%E8%A7%86%E9%A2%91%E5%90%AF%E5%8A%A8%E5%9B%BE.gif)

### 新加入视频的构造方法，简介如下：

```objc
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

```

### 方法使用

```objc
    // 判断第一次进入
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
    
        NSLog(@"第一次进入");
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];

        // 根据视频名称和类型创建启动图
        SHStartPageView *shStartPageView = [[SHStartPageView alloc] initWithVideoName:@"1" videoType:@"mp4" enterButtonIsHidden:NO];
        [self.window.rootViewController.view addSubview:shStartPageView];
        
    }
```

#### [iOS开发_一键集成引导页](http://www.jianshu.com/p/141ff3b0dba2)


--------
## 3.28 加入图片引导页

### 效果图：

![点击跳过按钮效果](http://oixwuce1i.bkt.clouddn.com/%E7%82%B9%E5%87%BB%E8%B7%B3%E8%BF%87%E6%8C%89%E9%92%AE.gif)   ![未点击跳过按钮效果](http://oixwuce1i.bkt.clouddn.com/%E6%9C%AA%E7%82%B9%E5%87%BB%E8%B7%B3%E8%BF%87%E6%8C%89%E9%92%AE.gif)

### 方法简介：
```objc
/**
 根据图片数组创建SHStartPageView

 @param imageArray 引导页图片数组
 @param isHidden 点击进入按钮是否隐藏
 @return SHStartPageView
 */
- (instancetype)initWithImageArray:(NSArray *)imageArray
               enterButtonIsHidden:(BOOL)isHidden;
```


### 方法使用：
#### 1.下载SHStartPageViewDemo将文件中的SHStartPageView文件夹拖到自己的工程中，并在AppDelegate中导入头文件 #import "SHStartPageView.h"

#### 2.使用自定义的创建方式根据图片数组和是否显示点击进入按钮创建引导图
```objc
/**
	// 初始化图片数组
	NSArray *imageArray = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"];
	// 创建并添加引导页
    SHStartPageView *shStartPageView = [[SHStartPageView alloc] initWithImageArray:imageArray enterButtonIsHidden:NO];
    [self.window.rootViewController.view addSubview:shStartPageView];
```

但我们经常会使用下面这样创建

```objc
/**
	// 判断第一次进入
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
    
        NSLog(@"第一次进入");
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];

        NSArray *imageArray = @[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"];
        SHStartPageView *shStartPageView = [[SHStartPageView alloc] initWithImageArray:imageArray enterButtonIsHidden:NO];
        [self.window.rootViewController.view addSubview:shStartPageView];
        
    }
```


#### [iOS开发_一键集成引导页](http://www.jianshu.com/p/141ff3b0dba2)