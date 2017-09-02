//
//  ViewController.m
//  WaxJs
//
//  Created by anyswang on 2017/8/3.
//  Copyright © 2017年 anyswang. All rights reserved.
//

#import "ViewController.h"
#import "JSView.h"
#import "JSColor.h"
#import "WJContext.h"
#import <AudioToolbox/AudioToolbox.h>
#import "JSAudioUtil.h"

@interface ViewController ()

@property (nonatomic, strong) WJContext *jsContext;

@property (nonatomic, strong) NSArray *numberButtons;

@property (nonatomic, strong) UIButton *dotButton;

@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *minusButton;
@property (nonatomic, strong) UIButton *multiplyButton;
@property (nonatomic, strong) UIButton *divideButton;
@property (nonatomic, strong) UIButton *amountButton;
@property (nonatomic, strong) UIButton *addminusButton;
@property (nonatomic, strong) UIButton *acButton;

@property (nonatomic, strong) UIButton *mcButton;
@property (nonatomic, strong) UIButton *mAddButton;
@property (nonatomic, strong) UIButton *mMinusButton;
@property (nonatomic, strong) UIButton *mrButton;

@property (nonatomic, strong) UIImageView *topImageView;

@property (nonatomic, strong) NSMutableDictionary *soundIDs;

@end

@implementation ViewController

@synthesize screenView = _screenView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:228.f/255.f green:227.f/255.f blue:226.f/255.f alpha:1.f];
    
    self.topImageView = [[UIImageView alloc] init];
    [self.view addSubview:self.topImageView];
    self.topImageView.image = [UIImage imageNamed:@"cal_text.png"];
    self.topImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.dotButton = [self addButtonWidthNormal:@"dot.png" andHighlighted:@"dot_down.png" andTag:ButtonTag_dot];
    self.addButton = [self addButtonWidthNormal:@"add.png" andHighlighted:@"add_down.png" andTag:ButtonTag_add];
    self.minusButton = [self addButtonWidthNormal:@"minus.png" andHighlighted:@"minus_down.png" andTag:ButtonTag_minuns];
    self.multiplyButton = [self addButtonWidthNormal:@"multiply.png" andHighlighted:@"multiply_down.png" andTag:ButtonTag_multiply];
    self.divideButton = [self addButtonWidthNormal:@"div.png" andHighlighted:@"div_down.png" andTag:ButtonTag_divide];
    self.amountButton = [self addButtonWidthNormal:@"amount.png" andHighlighted:@"amount_down.png" andTag:ButtonTag_amount];
    self.addminusButton = [self addButtonWidthNormal:@"addminus.png" andHighlighted:@"addminus_down.png" andTag:ButtonTag_addminus];
    self.acButton = [self addButtonWidthNormal:@"ac.png" andHighlighted:@"ac_down.png" andTag:ButtonTag_ac];
    
    self.mcButton = [self addButtonWidthNormal:@"mc.png" andHighlighted:@"mc_down.png" andTag:ButtonTag_mc];
    self.mAddButton = [self addButtonWidthNormal:@"madd.png" andHighlighted:@"madd_down.png" andTag:ButtonTag_mAdd];
    self.mMinusButton = [self addButtonWidthNormal:@"mminus.png" andHighlighted:@"mminus_down.png" andTag:ButtonTag_mMinus];
    self.mrButton = [self addButtonWidthNormal:@"mr.png" andHighlighted:@"mr_down.png" andTag:ButtonTag_mr];
    
    NSMutableArray *numberViews = [[NSMutableArray alloc] init];
    for (int i = 0 ; i < 10; i++) {
        UIView *view = [self addButtonWidthNormal:[NSString stringWithFormat:@"d%d.png", i] andHighlighted:[NSString stringWithFormat:@"d%d_down.png", i] andTag:i];
        [numberViews addObject:view];
    }
    self.numberButtons = numberViews;
    
    self.screenView = [[WJScreenView alloc] init];
    [self.view addSubview:self.screenView];
    
    [self layout];
    
    NSString*  bundlePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"JavaScript"];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.%@", bundlePath, @"ViewController", @"js"];
    NSString *script = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    //创建虚拟机
    JSVirtualMachine *vm = [[JSVirtualMachine alloc] init];
    
    //创建上下文
    self.jsContext = [[WJContext alloc] initWithVirtualMachine:vm];
    
    self.jsContext[@"self"] = self;
    [self.jsContext importClass:JSAudioUtil.class];
    
    [self.jsContext evaluateScript:script];
}

- (UIButton *)addButtonWidthNormal:(NSString *)normal andHighlighted:(NSString *)highlighted andTag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:button];
    [button setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highlighted] forState:UIControlStateHighlighted];
    button.tag = tag;
    [button addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)onButtonClick:(UIButton *)button
{
    JSValue *buttonEvent = self.jsContext[@"onButtonClick"];
    [buttonEvent callWithArguments:@[@(button.tag)]];
}

- (void)layout
{
    self.topImageView.frame = CGRectMake(0, 40, self.view.frame.size.width, 12);
    
    CGFloat screenWidth = self.view.frame.size.width-30;
    CGFloat screenHeight = screenWidth*30/102;
    self.screenView.frame = CGRectMake((self.view.frame.size.width-screenWidth)/2, self.topImageView.frame.origin.y + self.topImageView.frame.size.height+20, screenWidth, screenHeight);
    
    int row = 6;
    int column = 4;
    
    CGFloat cellWidth = self.screenView.frame.size.width/column;
    CGFloat cellHeight = cellWidth*225/261;
    
    CGFloat offsetY = self.screenView.frame.origin.y + self.screenView.frame.size.height + 40;
    CGFloat offseX = (self.view.frame.size.width - self.screenView.frame.size.width)/2;
    
    for (int i = 0; i < row; i++) {
        
        for (int j = 0; j < column; j++) {
            UIView *view;
            if (i == 0) {
                if (j == 0) view = self.mcButton;
                else if (j == 1) view = self.mAddButton;
                else if (j == 2) view = self.mMinusButton;
                else if (j == 3) view = self.mrButton;
            }else if (i == 1) {
                if (j == 0) view = self.acButton;
                else if (j == 1) view = self.addminusButton;
                else if (j == 2) view = self.divideButton;
                else if (j == 3) view = self.multiplyButton;
            }else if ( i >= 2 && i <= 4 && j <= 2) {
                view = [self.numberButtons objectAtIndex:(4-i)*3+j+1];
            }else if ( i == 2 && j == 3) {
                view = self.minusButton;
            }else if ( i == 3 && j == 3) {
                view = self.addButton;
            }else if ( i == 4 && j == 3) {
                view = self.amountButton;
            }else if ( i == 5 && j == 0) {
                view = [self.numberButtons objectAtIndex:0];
            }else if ( i == 5 && j == 2) {
                view = self.dotButton;
            }
            
            if ( i == 4 && j == 3) {
                view.frame = CGRectMake(j*cellWidth+offseX, i*cellHeight+offsetY, cellWidth, cellHeight*2);
            }else if ( i == 5 && j == 0) {
                view.frame = CGRectMake(j*cellWidth+offseX, i*cellHeight+offsetY, cellWidth*2, cellHeight);
            }else{
                view.frame = CGRectMake(j*cellWidth+offseX, i*cellHeight+offsetY, cellWidth, cellHeight);
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
