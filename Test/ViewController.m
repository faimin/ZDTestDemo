//
//  ViewController.m
//  Test
//
//  Created by 符现超 on 2016/12/10.
//  Copyright © 2016年 Zero.D.Saber. All rights reserved.
//

#import "ViewController.h"
@import ObjectiveC;
#import "CombineViewController.h"
#import "SearchConditionController.h"
#import "SearchConditionView.h"
#import "BlueViewController.h"
#import "TestTopView.h"
#import "UIButton+ZDUtility.h"
//#import "UIViewController+SearchConditionPlus.h"


@interface ViewController ()
@property (nonatomic, strong) UIButton *button;
@end


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self setup];
}

- (void)setup
{
    [self macroTest];

    [self associated];
    
    NSLog(@"testSpace");
}

- (void)macroTest
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_9_3
    NSLog(@"啦啦啦啦啦");
#endif
}

- (void)associated {
    objc_setAssociatedObject(self, @selector(associated), @"value", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, @selector(associated), nil, OBJC_ASSOCIATION_COPY_NONATOMIC);
    id value = objc_getAssociatedObject(self, @selector(associated));
    NSLog(@"获取到的绑定的结果： %@", value); // nil
    
    void *any = nil;
    {
        NSObject *obj = [NSObject new];
        any = (__bridge void *)obj;
    }
    //NSLog(@"------ %@", any);
    NSLog(@"xxxxxxxxxxxxxxxxxxxxxxxx");
}

- (void)ajfoaw
{
    NSString *a = @"a";
    NSString *b = @"b";
    NSLog(@"%@%@", a, b);
}

- (void)setup:(NSString *)name
    withPrams:(NSDictionary *)paramsDict
            a:(NSString *)a
            b:(NSString *)b
            c:(NSString *)c
{
    NSLog(@"");
}

- (IBAction)push:(id)sender
{
#if 1
    SearchConditionController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([SearchConditionController class])];
#else
    CombineViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([CombineViewController class])];
#endif

    vc.topView = ({
        TestTopView *view = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TestTopView class]) owner:nil options:nil].lastObject;
        view.backgroundColor = [UIColor purpleColor];
        view;
    });
    BlueViewController *blue = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([BlueViewController class])];
    vc.bottomController = blue;
    //vc.topViewHeight = 200;
    vc.titleView = ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = [UIFont systemFontOfSize:14.f];
        button.backgroundColor = [UIColor yellowColor];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitle:@"综合-全部-all-啊哈" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"top-arrw"] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button zd_imagePosition:ZDImagePosition_Right spacing:5.f];
        button;
    });

    [self.navigationController showViewController:vc sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
