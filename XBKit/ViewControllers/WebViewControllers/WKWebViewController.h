//
//  WKWebViewController.h
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2017/12/28.
//  Copyright © 2017年 Xinbo Hong. All rights reserved.
//

/*
 *  控件名称:    封装wkWebView控制器
 *  控件完成情况: 进行了部分优化
 *  最后记录时间: 2018/5/25
 */

#import <UIKit/UIKit.h>

typedef void(^pushNewInterfaceBlock)(void);

@interface WKWebViewController : UIViewController

@property (nonatomic, strong) NSString *url;

@property (nonatomic, strong) NSString *html;

@property (nonatomic, strong) NSString *localHtmlPath;

@property (nonatomic, assign, getter=isCanDownRefresh) BOOL canDownRefresh;

@property (nonatomic, copy) pushNewInterfaceBlock pushBlock;


- (void)loadHtmlString:(NSString *)html;
@end
