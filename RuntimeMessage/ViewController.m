//
//  ViewController.m
//  RuntimeMessage
//
//  Created by Code_Hou on 2017/3/25.
//  Copyright © 2017年 侯森魁. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+viewWillAppear.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)method1{
    
    NSLog(@"输出%@",NSStringFromSelector(_cmd));
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //SEL 又叫选择器，是表示一个方法的selector的指针
    //定义如下:
    //typedef struct objc_selector * SEL;
    SEL sel1 = @selector(method1);
    
    NSLog(@"sel1:%s sel1= %p",sel1,sel1);
    
    SEL sel2 =  NSSelectorFromString(@"method1");
    
    NSLog(@"sel2:%s sel2= %p",sel2,sel2);
    
    SEL sel3 = sel_registerName("method1");

    [self performSelector:sel1];
    
    [self performSelector:sel2];
    
    [self performSelector:sel3];
    
    /*
     如果以[object message]的方式调用方法，如果message 没有实现，编译器会报错
     
     但是如果是以performSelector...的形式 需要等到运行时才能确定 object 是否能接收message 消息。
     
     
     */
    

    //本质上，SEL只是一个指向方法的指针，（准确的说，只是一个根据方法名hash化了的KEY值，能唯一代表一个方法），它的存在只是为了加快方法的查询速度
    //我们可以在运行时添加新的selector,也可以在运行时获取已经存在的selector,我们可以通过下面三种方法来获取SEL:
    /*
     1.sel_registerName 函数
     2.Objective-C编译器提供的@selector()
     3.NSSelectorFromString()方法
     
     */
    
    /*
     IMP 实际上是一个函数指针，指向方法实现得到首地址
     定义为：id (*IMP)(id,SEL,...)
     */
    /*
     Method
     
     Method 用于表示类定义中方法,定义为
     
    typedef struct objc_method * Method;
    
    struct objc_method{
        
        SEL method_name; //方法名
        char *method_types;
        IMP method_imp; //方法实现
    }
     */
    /*
     查找方法缓存表、如果没有去再去找方法列表，如果没有去父类找、直到NSObejct,如果没有可以动态添加这个方法，如果没有添加，可以把这个方法交给其他对象去执行，
     
     提一个问题：如何让程序永远不会崩溃。
     
     思路：自NSObject给写一个类扩展 ,然后重写一下方法：貌似不行啊？？
     
     在程序的+(void)load 阶段 使用方法交换 ？
     
     + (BOOL)instancesRespondToSelector:(SEL)aSelector;
     
     - (IMP)methodForSelector:(SEL)aSelector;
     + (IMP)instanceMethodForSelector:(SEL)aSelector;
     - (void)doesNotRecognizeSelector:(SEL)aSelector;
     
     */

    
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [self viewWillAppearCategroy:animated];
}
//- (void)viewWillAppearCategroy:(BOOL)animated{
//    
//    NSLog(@"调用本类的方法");
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
