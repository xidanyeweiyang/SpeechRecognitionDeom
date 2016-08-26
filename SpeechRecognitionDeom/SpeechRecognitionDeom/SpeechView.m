//
//  SpeechView.m
//  kedaxunfei
//
//  Created by 刘明 on 16/8/25.
//  Copyright © 2016年 刘明. All rights reserved.
//

#import "SpeechView.h"
#import <Masonry.h>

@implementation SpeechView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self == [super initWithFrame:frame]) {
        
        [self setupUI];
    }
    return self;
}


- (void)showText:(NSString *)text{
    
    self.label.text = text;
}

- (void)setVolume:(NSInteger)volume{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        if (volume < 5 && volume > 0) {
            
            self.imageView.image  = [UIImage imageNamed:@"mike01"];
        }else if (volume < 10 && volume > 5){
            
            self.imageView.image  = [UIImage imageNamed:@"mike02"];

        }else if (volume < 20 && volume > 10){
            
            self.imageView.image  = [UIImage imageNamed:@"mike03"];
            
        }else{
            
            self.imageView.image  = [UIImage imageNamed:@"mike00"];
        }
        
    }];
   
    
    
}

- (void)setupUI{
//    
    __weak typeof(self) weakSelf = self;
    
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]];
    
    UIView *alertView = [[UIView alloc] init];
    
    alertView.layer.cornerRadius = 10;
    alertView.layer.masksToBounds = YES;

    [self addSubview:alertView];
    
    alertView.backgroundColor = [UIColor whiteColor];
    
    [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.equalTo(weakSelf);
        make.left.equalTo(@30);
        make.height.mas_equalTo(180);
    }];

    
    UILabel *label = [[UILabel alloc] init];
    self.label = label;
    label.textColor = [UIColor orangeColor];
    label.font = [UIFont systemFontOfSize:18];
    [alertView addSubview:label];
    label.textAlignment = NSTextAlignmentCenter;
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(alertView);
        
        make.top.equalTo(@10);
    }];
    

    UIView *btnBackView = [[UIView alloc] init];
    
    [alertView addSubview:btnBackView];
    
    btnBackView.backgroundColor = [UIColor lightGrayColor];
    
    [btnBackView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.left.right.equalTo(alertView);
        make.height.mas_equalTo(40);
        
    }];
    
 
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [cancelBtn setBackgroundColor:[UIColor whiteColor]];
    
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [cancelBtn addTarget:self action:@selector(didClickCacncel) forControlEvents:UIControlEventTouchUpInside];
    
    [btnBackView addSubview:cancelBtn];
    
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.left.equalTo(btnBackView);
        make.top.equalTo(@1);
        
    }];
    
    
    
    UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [finishBtn setBackgroundColor:[UIColor whiteColor]];
    
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    
    [finishBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    finishBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        
    [finishBtn addTarget:self action:@selector(didClickFinish) forControlEvents:UIControlEventTouchUpInside];
    
    [btnBackView addSubview:finishBtn];
    
    [finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.right.equalTo(btnBackView);
        make.left.equalTo(cancelBtn.mas_right).with.offset(1);
        make.width.height.equalTo(cancelBtn);
        
    }];
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    
    self.imageView.image  = [UIImage imageNamed:@"mike00"];
    
    self.imageView = imageView;
    
    [alertView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(alertView);
        
        make.bottom.equalTo(btnBackView.mas_top).with.offset(-5);
        
        make.height.mas_equalTo(100);
        make.width.mas_equalTo(130);
    }];
    
    
    
}

- (void)didClickCacncel{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSpeechCacncelBtn)]) {
       
        [self.delegate didSpeechCacncelBtn];
    }
    
}

- (void)didClickFinish{
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSpeechFinishedBtn)]) {
        
        [self.delegate didSpeechFinishedBtn];
    }

}










@end
