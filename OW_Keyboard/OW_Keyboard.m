//
//  OWKeyboard.m
//  OWKeyboard
//
//  Created by 上海银来（集团）有限公司 on 15/11/29.
//  Copyright © 2015年 Old.Wang. All rights reserved.
//
#define LineWidth 1
#define NumFont [UIFont systemFontOfSize:27]
#define FrameW [UIScreen mainScreen].bounds.size.width
#define DefulatColor [UIColor blackColor]
#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#import "OW_Keyboard.h"
@interface OW_Keyboard()

@property (nonatomic,strong) NSArray * array;

@end

@implementation OW_Keyboard

static CGFloat const rowHeight = 40;

-(NSArray *)array
{
    if (_array == nil) {
        _array = [[NSArray alloc] init];
    }
    return _array;
}

+(instancetype)ow_keyboard
{
    return [[super alloc] initWithFrame:CGRectMake(0, 200, FrameW, 216)];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bounds = CGRectMake(0, 0, FrameW, 250);
        _array = [NSArray arrayWithObjects:@"ABC",@"DEF",@"GHI",@"JKL",@"MNO",@"RST",@"UVW",@"XYZW", nil];
        for (int i = 0; i < 4; i ++) {
            for (int j = 0; j < 3; j ++) {
                UIButton * button = [self buttonWithX:i Y:j];
                [self addSubview:button];
            }
        }
    }
    //    创建一个类似toolbar
    UIView * whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, FrameW, 38)];
    whiteView.backgroundColor = [UIColor whiteColor];
    //    完成按钮
    UIButton *  completeBtn = [[UIButton alloc] initWithFrame:CGRectMake(FrameW-80, 0, 80, 38)];
    [completeBtn setTitle:@"完成" forState:UIControlStateNormal];
    [completeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [completeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [completeBtn addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:completeBtn];
    
    
    
    [self addSubview:whiteView];
    
    UIColor *color = RGBColor(188, 192, 199);
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(FrameW/3-1, rowHeight, LineWidth, 216)];
    line1.backgroundColor = color;
    [self addSubview:line1];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(FrameW/3*2,rowHeight, LineWidth, 216)];
    line2.backgroundColor = color;
    [self addSubview:line2];
    
    for (int i=0; i<3; i++){
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 54*(i+1)+rowHeight, FrameW, LineWidth)];
        line.backgroundColor = color;
        [self addSubview:line];
    }
    return self;
}

-(UIButton *)buttonWithX:(NSInteger) x Y:(NSInteger)y
{
    CGFloat buttonX;
    CGFloat buttonW;
    switch (y) {
        case 0:
            buttonX = 0.0;
            buttonW = FrameW/3-1;
            break;
        case 1:
            buttonX = FrameW/3;
            buttonW = FrameW/3;
            break;
        case 2:
            buttonX = FrameW/3*2+1;
            buttonW = FrameW/3-1;
            break;
            
        default:
            break;
    }
    CGFloat buttonY = rowHeight + x * 54;
    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, buttonY, buttonW, 54)];
    
    NSInteger num = x * 3 + y +1;
    button.tag = num;
    [button addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    UIColor *colorNormal = RGBColor(252, 252, 252);
    UIColor *colorHightlighted = RGBColor(186, 189, 194);
    
    if (num == 10 || num == 12){
        UIColor *colorTemp = colorNormal;
        colorNormal = colorHightlighted;
        colorHightlighted = colorTemp;
    }
    button.backgroundColor = colorNormal;
    CGSize imageSize = CGSizeMake(buttonW, 54);
//    开始图片上下文
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [colorHightlighted set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
//    把当前图片的图片拿到
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
//    结束绘画
    UIGraphicsEndImageContext();
//    丢给按钮
    [button setImage:pressedColorImg forState:UIControlStateHighlighted];
    
    if (num<10){
        UILabel *labelNum = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, buttonW, 28)];
        [self label:labelNum setlableText:[NSString stringWithFormat:@"%zd",num] color:DefulatColor textAligment:1];
        labelNum.font = NumFont;
        [button addSubview:labelNum];
        
        if (num != 1){
            UILabel *labelLetter = [[UILabel alloc] initWithFrame:CGRectMake(0, 33, buttonW, 16)];
            labelLetter.text = [_array objectAtIndex:num-2];
            [self label:labelLetter setlableText:[_array objectAtIndex:num-2] color:DefulatColor textAligment:1];
            labelLetter.font = [UIFont systemFontOfSize:12];
            [button addSubview:labelLetter];
        }
    }else if (num == 11){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 11, buttonW, 28)];
        [self label:label setlableText:@"0" color:DefulatColor textAligment:1];
        label.font = NumFont;
        [button addSubview:label];
    }else if (num == 10){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, buttonW, 28)];
        [self label:label setlableText:@"." color:DefulatColor textAligment:1];
        [button addSubview:label];
    }else{
        CGFloat imgX = (FrameW/3-22)/2;
        UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(imgX, 16, 22, 17)];
        arrow.image = [UIImage imageNamed:@"OW_Keyboard.bundle/Keyboard.png"];
        [button addSubview:arrow];
    }
    return button;
}

-(void)label:(UILabel *)lable setlableText:(NSString *)text color:(UIColor *)color textAligment:(NSTextAlignment) alignment
{
    lable.text = text;
    lable.textColor = color;
    lable.textAlignment = alignment;
}

-(void)complete
{
    !_completeBlock ? : _completeBlock();
}
-(void)clickBtn:(UIButton *)sender
{
    if (sender.tag == 10)
        !_numberKeyboardDian ? : _numberKeyboardDian(@".");
    else if (sender.tag == 12)
        !_numberKeyboardBackspace ? : _numberKeyboardBackspace();
    else{
        NSInteger num = sender.tag;
        if (sender.tag == 11) num = 0;
        !_numberKeyboardInput ? : _numberKeyboardInput(num);
    }
}

@end
