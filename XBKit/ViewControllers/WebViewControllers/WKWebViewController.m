//
//  WKWebViewController.m
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2017/12/28.
//  Copyright © 2017年 Xinbo Hong. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import "WeakScriptMessageDelegate.h"

static NSString *const kPersonalOpenAccount   = @"personalOpenAccount";
static NSString *const kEnterpriseOpenAccount = @"enterpriseOpenAccount";

static NSString *const kPersonalChangeCard   = @"personalChangeCard";
static NSString *const kPersonalChangeMobile = @"personalChangeMobile";
static NSString *const kPersonalChangeAuth   = @"personalChangeAuth";


@interface WKWebViewController ()<WKNavigationDelegate,WKUIDelegate,UIGestureRecognizerDelegate,WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong) UIProgressView *loadingProgressView;

@property (nonatomic, strong) UIBarButtonItem *backBarButtonItem;
@property (nonatomic, strong) UIBarButtonItem *closeBarButtonItem;
@property (nonatomic, strong) id <UIGestureRecognizerDelegate>delegate;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@property (nonatomic, strong) UIButton *reloadButton;

@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithWhite:240 / 255.0 alpha:1.0f];
    //    [self.view addSubview:self.reloadButton];
    [self.view addSubview:self.wkWebView];
    [self.view addSubview:self.loadingProgressView];
    
    [self initNav];
    
    if (self.url) {
        [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
        
    } else if (self.html) {
        
        [self.wkWebView loadHTMLString:self.html baseURL:nil];
    } else {
        NSURL *url = [NSURL URLWithString:self.localHtmlPath];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.wkWebView loadRequest:request];
    }
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.navigationController.viewControllers.count > 1) {
        self.delegate = self.navigationController.interactivePopGestureRecognizer.delegate;
        self.navigationController.interactivePopGestureRecognizer.delegate = self;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.interactivePopGestureRecognizer.delegate = self.delegate;
}

- (void)dealloc {
    [self.wkWebView stopLoading];
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    self.wkWebView.UIDelegate = nil;
    self.wkWebView.navigationDelegate = nil;
    
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:kPersonalOpenAccount];
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:kEnterpriseOpenAccount];
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:kPersonalChangeCard];
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:kPersonalChangeMobile];
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:kPersonalChangeAuth];
    
}

#pragma mark - **************** Event response methods
- (void)webViewReloadWithWKWebViewController {
    [self.wkWebView reload];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.loadingProgressView.progress = [change[@"new"] floatValue];
        if (self.loadingProgressView.progress == 1.0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.loadingProgressView.hidden = YES;
            });
        }
    }
}
#pragma mark - WKNavigationDelegate
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    [webView reload];
}
//准备加载页面
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"2--页面开始加载时调用.==%s",__func__);
    
    webView.hidden = NO;
    self.loadingProgressView.hidden = NO;
    if ([webView.URL.scheme isEqual:@"about"]) {
        webView.hidden = YES;
    }
}
//内容开始加载
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"4--内容返回时调用，得到请求内容时调用。==%s",__func__);
}
//页面加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"5--页面加载完成时调用。==%s",__func__);
    
    [webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable title, NSError * _Nullable error) {
        self.navigationController.title = title;
    }];
    
    [self showLeftBarButtonItem];
    [self.refreshControl endRefreshing];
}

//页面加载失败
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    webView.hidden = YES;
    NSLog(@"error1:%@",error);
}

//页面加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"error2:%@",error);
}

//接收到服务器跳转请求的代理
- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    NSLog(@"接收到服务器跳转请求之后调用==%s",__func__);
    if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
        // 如果没有错误的情况下 创建一个凭证，并使用证书
        if (challenge.previousFailureCount == 0) {
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
        }else {
            // 验证失败，取消本次验证
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        }
    }else {
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        
    }
}

//在收到响应后，决定是否跳转（同上）
//该方法执行在内容返回之前
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
//    NSLog(@"1--在请求发送之前，决定是否跳转。%s",__func__);
//    //允许跳转
//    decisionHandler(WKNavigationResponsePolicyAllow);
//
//    //不允许跳转
//    //    decisionHandler(WKNavigationActionPolicyCancel);
//
//}

//在请求发送之前，决定是否跳转 -> 该方法如果不实现，系统默认跳转。如果实现该方法，则需要设置允许跳转，不设置则报错。
//该方法执行在加载界面之前
//Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'Completion handler passed to -[ViewController webView:decidePolicyForNavigationAction:decisionHandler:] was not called'
//- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
//    //允许跳转
//    decisionHandler(WKNavigationActionPolicyAllow);
//    //不允许跳转
//    //    decisionHandler(WKNavigationResponsePolicyCancel);
//    NSLog(@"3--在收到响应后，决定是否跳转。%s",__func__);
//}
#pragma mark - **************** WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    // 判断是否是调用原生的
    if ([message.name isEqualToString:kPersonalOpenAccount]) {
        NSLog(@"data: %@",message.body);
    } else if ([message.name isEqualToString:kEnterpriseOpenAccount]) {
        NSLog(@"data: %@",message.body);
    } else if ([message.name isEqualToString:kPersonalChangeCard]) {
        NSLog(@"data: %@",message.body);
    }  else if ([message.name isEqualToString:kPersonalChangeMobile]) {
        NSLog(@"data: %@",message.body);
    } else if ([message.name isEqualToString:kPersonalChangeAuth]) {
        NSLog(@"data: %@",message.body);
    }
}
#pragma mark - **************** Navigation
- (void)initNav {
    [self showLeftBarButtonItem];
}

- (void)showLeftBarButtonItem {
    if ([self.wkWebView canGoBack]) {
        self.navigationItem.leftBarButtonItems = @[self.backBarButtonItem,self.closeBarButtonItem];
    } else {
        self.navigationItem.leftBarButtonItem = self.backBarButtonItem;
    }
}

- (void)navigationBack:(UIBarButtonItem *)sender {
    if ([self.wkWebView canGoBack]) {
        [self.wkWebView goBack];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)navigationClose:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return self.navigationController.viewControllers.count > 1;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return self.navigationController.viewControllers.count > 1;
}
#pragma mark  Navigation gatter and setter
- (UIBarButtonItem *)backBarButtonItem {
    if (!_backBarButtonItem) {
        self.backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_icon_back"] style:UIBarButtonItemStylePlain target:self action:@selector(navigationBack:)];
    }
    return _backBarButtonItem;
}

- (UIBarButtonItem *)closeBarButtonItem {
    if (!_closeBarButtonItem) {
        self.closeBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(navigationClose:)];
    }
    return _closeBarButtonItem;
}

#pragma mark - **************** Getter and setter
- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        //创建配置
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.preferences = [[WKPreferences alloc] init];
        config.allowsInlineMediaPlayback = YES;
        config.preferences.javaScriptEnabled = YES;
        config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
        
        self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, kTopBarHeight(), CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - kTopBarHeight()) configuration:config];
        self.wkWebView.UIDelegate = self;
        self.wkWebView.navigationDelegate = self;
        self.wkWebView.allowsBackForwardNavigationGestures = YES;
        
        if (self.isCanDownRefresh) {
            self.wkWebView.scrollView.refreshControl = self.refreshControl;
        }
        [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        
        [self addMethodName];
        
    }
    return _wkWebView;
}

- (void)addMethodName {
    // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
    [self.wkWebView.configuration.userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:kPersonalOpenAccount];
    [self.wkWebView.configuration.userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:kEnterpriseOpenAccount];
    [self.wkWebView.configuration.userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:kPersonalChangeCard];
    [self.wkWebView.configuration.userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:kPersonalChangeMobile];
    [self.wkWebView.configuration.userContentController addScriptMessageHandler:[[WeakScriptMessageDelegate alloc] initWithDelegate:self] name:kPersonalChangeAuth];
}

- (UIRefreshControl *)refreshControl {
    if (!_refreshControl) {
        self.refreshControl = [[UIRefreshControl alloc] init];
        [self.refreshControl addTarget:self action:@selector(webViewReloadWithWKWebViewController) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
}

- (UIProgressView *)loadingProgressView {
    if (!_loadingProgressView) {
        self.loadingProgressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, kTopBarHeight(), CGRectGetWidth(self.view.frame), 2)];
        self.loadingProgressView.progressTintColor = [UIColor blueColor];
    }
    return _loadingProgressView;
}

- (UIButton *)reloadButton {
    if (!_reloadButton) {
        self.reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.reloadButton.frame = CGRectMake(0, 0, 150, 150);
        self.reloadButton.center = self.view.center;
        self.reloadButton.layer.cornerRadius = CGRectGetHeight(self.reloadButton.frame) / 2;
        self.reloadButton.backgroundColor = [UIColor redColor];
        [self.reloadButton setTitle:@"您的网络有问题，请检查您的网络设置" forState:UIControlStateNormal];
        [self.reloadButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.reloadButton setTitleEdgeInsets:UIEdgeInsetsMake(200, -60, 0, -50)];
        self.reloadButton.titleLabel.numberOfLines = 0;
        self.reloadButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.reloadButton.enabled = NO;
    }
    return _reloadButton;
}

- (void)setUrl:(NSString *)url {
    _url = url;
    if (![self.url hasPrefix:@"https"]) {
        self.url = [NSString stringWithFormat:@"https://%@",self.url];
    }
}

- (void)setHtml:(NSString *)html {
    if (html) {
        _html = html;
    }
}

- (void)loadHtmlString:(NSString *)html {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true);
    NSString *saveDirectory = [paths objectAtIndex:0];
    NSString *saveFileName = @"index.html";
    NSString *filepath = [saveDirectory stringByAppendingPathComponent:saveFileName];
    [html  writeToFile:filepath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    NSString *str = [saveDirectory stringByAppendingPathComponent:saveFileName];
    self.localHtmlPath = str;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
