//
//  SpeechView.h
//  kedaxunfei
//
//  Created by 刘明 on 16/8/25.
//  Copyright © 2016年 刘明. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SpeechViewDelegate <NSObject>

- (void)didSpeechFinishedBtn;

- (void)didSpeechCacncelBtn;

@end

@interface SpeechView : UIView

- (void)showText:(NSString *)text;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, assign) NSInteger volume;

@property (nonatomic, weak) id<SpeechViewDelegate> delegate;

@end
