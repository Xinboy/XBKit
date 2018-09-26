//
//  BasedTabBarViewController.m
//  XBCodingRepo
//
//  Created by Xinbo Hong on 2018/4/10.
//  Copyright © 2018年 Xinbo Hong. All rights reserved.
//

#import "BasedTabBarViewController.h"
#import "MidProminentTabBar.h"

#import "SlipViewController.h"
#import "ViewController.h"
@interface BasedTabBarViewController ()<UITabBarControllerDelegate>

@property (nonatomic, strong) MidProminentTabBar *midTabbar;

@end

@implementation BasedTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置中间突出的内容
    self.midTabbar = [[MidProminentTabBar alloc] init];
    [self.midTabbar.midButton addTarget:self action:@selector(midTabBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    self.midTabbar.translucent = NO;
    [self setValue:self.midTabbar forKey:@"tabBar"];
    
    
    self.delegate = self;
    
    [self addChildViewControllers];
    
}

#pragma mark - **************** Event response methods
- (void)midTabBarButtonAction:(UIButton *)sender {
    self.selectedIndex = 2;
    NSLog(@"---");
}

#pragma mark - **************** UIView frame / masonry methods
- (void)addChildViewControllers{
    //图片大小建议32*32
    [self addOneChildVC:[[ViewController alloc] init] title:@"首页" imageName:@"tab1_n" selectedImageName:@"tab1_p"];
    [self addOneChildVC:[[ViewController alloc] init] title:@"扩展" imageName:@"tab2_n" selectedImageName:@"tab2_p"];
    //中间这个不设置东西，只占位
    [self addOneChildVC:[[ViewController alloc] init] title:@"旋转" imageName:@"" selectedImageName:@""];
    [self addOneChildVC:[[ViewController alloc] init] title:@"发现" imageName:@"tab3_n" selectedImageName:@"tab3_p"];
    [self addOneChildVC:[[ViewController alloc] init] title:@"我" imageName:@"tab4_n" selectedImageName:@"tab4_p"];
}

/**
 *  添加自控制器
 *
 *  @param childVC           自控制器
 *  @param title             标题
 *  @param imageName         图标名称
 *  @param selectedImageName 选择状态 图标名称
 */
- (void)addOneChildVC:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName{
    
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:imageName];
    //禁止渲染
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVC.tabBarItem.selectedImage = selectedImage;
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childVC];
    [self addChildViewController:nav];
}

#pragma mark - **************** Getter and setter

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
