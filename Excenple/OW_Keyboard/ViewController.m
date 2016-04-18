//
//  ViewController.m
//  OW_Keyboard
//
//  Created by 上海银来（集团）有限公司 on 16/4/18.
//  Copyright © 2016年 Old.Wang. All rights reserved.
//

#import "ViewController.h"
#import "OW_Keyboard.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UITextField * text = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 130, 40)];
    text.borderStyle = UITextBorderStyleBezel;
    [self.view addSubview:text];
    
    // Do any additional setup after loading the view, typically from a nib.
    //  自定义键盘
    OW_Keyboard *keyboard = [OW_Keyboard keyboard];
    text.inputView = keyboard;
    
    keyboard.numberKeyboardDian = ^(NSString * String){
        //        是否为空  只能有一个小数点
        text.text = [text.text stringByAppendingString:[NSString stringWithFormat:@"%@",String]];
    };
    
    keyboard.numberKeyboardBackspace = ^(){
        if (text.text.length != 0) text.text = [text.text substringToIndex:text.text.length -1];
    };
    
    keyboard.numberKeyboardInput = ^(NSInteger number){
        text.text = [text.text stringByAppendingString:[NSString stringWithFormat:@"%ld",number]];
    };
    
    keyboard.completeBlock = ^(){
        [text resignFirstResponder];
    };

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
