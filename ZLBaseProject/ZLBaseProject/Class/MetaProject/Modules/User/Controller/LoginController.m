//
//  LoginController.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/9.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "LoginController.h"
#import "ThirdPartLoginView.h"
#import "CountDownButton.h"
#import "UserRequest.h"
#import "UserInfoService.h"

@interface LoginController () <UITextFieldDelegate, ThirdPartLoginViewDelegate>

@property (nonatomic, strong) UIView *headBackgroundView;
@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *zoneLabel;
@property (nonatomic, strong) UITextField *phoneTextField;
@property (nonatomic, strong) UIView *lineView1;


@property (nonatomic, strong) UITextField *captchaTextField;
@property (nonatomic, strong) CountDownButton *captchaButton;
@property (nonatomic, strong) UIView *lineView2;


@property (nonatomic, strong) UIButton *nextButton;

@property (nonatomic, strong) ThirdPartLoginView *thirdLoginView;

@end

@implementation LoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ZLWhiteColor;
    
    [self showNavigationBar];
    self.title = @"登录";
}

- (void)initComponent {
    [self.view addSubview:self.headBackgroundView];
    [self.view addSubview:self.iconImageView];
    [self.view addSubview:self.zoneLabel];
    [self.view addSubview:self.phoneTextField];
    [self.view addSubview:self.lineView1];
    
    [self.view addSubview:self.captchaTextField];
    [self.view addSubview:self.captchaButton];
    [self.view addSubview:self.lineView2];
    
    [self.view addSubview:self.nextButton];
    //[self.view addSubview:self.ordinanceButton];
    //[self.view addSubview:self.ordinanceLabel];
    
    [self.view addSubview:self.thirdLoginView];
    
    [self setCaptchaButtonEnabled:YES];
}


#pragma mark - properties
- (UIView*)headBackgroundView {
    if (!_headBackgroundView) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, NAVBARHEIGHT, SCREENWIDTH, 160)];
        view.backgroundColor = ZLWhiteColor;
        _headBackgroundView = view;
    }
    return _headBackgroundView;
}

- (UIImageView*)iconImageView {
    if (!_iconImageView) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
        imageView.image = [UIImage imageNamed:@"login_head_icon"];
        imageView.centerX = SCREENWIDTH / 2;
        imageView.top = 102;
        _iconImageView = imageView;
    }
    return _iconImageView;
}

- (UILabel *)zoneLabel {
    if (!_zoneLabel) {
        _zoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _zoneLabel.textColor = ZLGray(42);
        _zoneLabel.font = ZLNormalFont(16);
        _zoneLabel.text = @"+86";
        [_zoneLabel sizeToFit];
        _zoneLabel.left = 50 + 25;
        _zoneLabel.bottom = self.lineView1.top - 4;
    }
    return _zoneLabel;
}

- (UITextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [[UITextField alloc] initWithFrame:CGRectMake(90, 0, SCREENWIDTH - 40 - 90, 32)];
        _phoneTextField.borderStyle = UITextBorderStyleNone;
        _phoneTextField.placeholder = @"请输入手机号";
        _phoneTextField.font = ZLNormalFont(14);
        _phoneTextField.keyboardType = UIKeyboardTypePhonePad;
        _phoneTextField.delegate = self;
        _phoneTextField.textColor = ZLGray(42);
        _phoneTextField.left = self.zoneLabel.right + 40;
        _phoneTextField.centerY = self.zoneLabel.centerY;
        _phoneTextField.width = self.lineView1.right - _phoneTextField.left;
    }
    return _phoneTextField;
}

- (UIView *)lineView1 {
    if ( !_lineView1 ) {
        _lineView1 = [[UIView alloc] initWithFrame:CGRectMake( 50, 13,SCREENWIDTH - 50*2, 1)];
        _lineView1.backgroundColor = ZLGray(229);
        _lineView1.top = self.headBackgroundView.bottom + (IS_IPHONE4?32:56);
    }
    
    return _lineView1;
}

- (UITextField *)captchaTextField {
    if ( !_captchaTextField ) {
        _captchaTextField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, SCREENWIDTH - 40 - 154 - 40, 32)];
        _captchaTextField.borderStyle = UITextBorderStyleNone;
        _captchaTextField.placeholder = @"请输入验证码";
        _captchaTextField.font = ZLNormalFont(14);
        _captchaTextField.keyboardType = UIKeyboardTypeNumberPad;
        _captchaTextField.delegate = self;
        _captchaTextField.textColor = ZLGray(42);
        _captchaTextField.bottom = self.lineView2.bottom;
        _captchaTextField.left = 50;
        _captchaTextField.width = self.lineView1.width - 62 - 12;
    }
    
    return _captchaTextField;
}

- (CountDownButton *)captchaButton {
    if (!_captchaButton) {
        _captchaButton = [CountDownButton instanceWithBegin:^(CountDownButton *countDownButton) {
        } couting:^NSString *(CountDownButton *countDownButton, NSUInteger second) {
            NSString *title = [NSString stringWithFormat:@"%zd秒",second];
            return title;
        } finished:^NSString *(CountDownButton *countDownButton, NSUInteger second) {
            [self setCaptchaButtonEnabled:YES];
            return @"重新获取";
        }];
        _captchaButton.frame = CGRectMake(0, 110 + NAVBARHEIGHT, 97, 35);
        _captchaButton.right = SCREENWIDTH - 20;
        [_captchaButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_captchaButton setTitleColor:ZLWhiteColor forState:UIControlStateNormal];
        [_captchaButton setTitleColor:ZLGray(178) forState:UIControlStateDisabled];
        _captchaButton.titleLabel.font = ZLNormalFont(16);
        _captchaButton.layer.masksToBounds = YES;
        _captchaButton.layer.cornerRadius = 4;
        [_captchaButton addTarget:self action:@selector(handleCaptchaButton) forControlEvents:UIControlEventTouchUpInside];
        _captchaButton.bottom = self.lineView2.top - 4;
        _captchaButton.right = self.lineView2.right - 12;
    }
    
    return _captchaButton;
}

- (UIView *)lineView2 {
    if (!_lineView2) {
        _lineView2 = [[UIView alloc] initWithFrame:CGRectMake( 50, 12,SCREENWIDTH - 50*2, 1)];
        _lineView2.backgroundColor = ZLGray(229);
        _lineView2.top = self.lineView1.bottom + 48;
    }
    
    return _lineView2;
}

- (UIButton *)nextButton {
    if ( !_nextButton ) {
        _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextButton.frame = CGRectMake(30, 270 + NAVBARHEIGHT, SCREENWIDTH - 30*2, 44);
        [_nextButton setTitle:@"登录" forState:UIControlStateNormal];
        [_nextButton setTitleColor:ZLWhiteColor forState:UIControlStateNormal];
        [_nextButton setTitleColor:ZLGray(178) forState:UIControlStateDisabled];
        _nextButton.titleLabel.font = ZLNormalFont(18);
        _nextButton.layer.masksToBounds = YES;
        _nextButton.layer.cornerRadius = 4;
        _nextButton.backgroundColor = ZLGray(235);
        _nextButton.enabled = NO;
        [_nextButton addTarget:self action:@selector(handleNextButton) forControlEvents:UIControlEventTouchUpInside];
        _nextButton.top = self.lineView2.bottom + 28;
        
    }
    return _nextButton;
}


- (ThirdPartLoginView *)thirdLoginView {
    if (!_thirdLoginView) {
        _thirdLoginView = [[ThirdPartLoginView alloc] init];
        _thirdLoginView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENWIDTH / 7 + 82);
        _thirdLoginView.delegate = self;
        _thirdLoginView.bottom = SCREENHEIGHT;
    }
    return _thirdLoginView;
}

- (void)handleCaptchaButton {
    NSString *phoneText = self.phoneTextField.text;
    
    if ([phoneText isEmptyString]) {
        [self showNotice:@"请输入手机号"];
        return;
    }
    
    NSDictionary *params = @{@"phone":phoneText};
    
    weakSelf(self);
    [self setCaptchaButtonEnabled:NO];
    [UserRequest getCaptchaWithParams:params success:^{
        strongSelf(self);
        [self.captchaButton startCountDownWithSecond:60];
    } failure:^(StatusModel *status) {
        
        [self setCaptchaButtonEnabled:YES];
        [self.captchaButton stopCountDown];
        [self showNotice:status.msg];
        
    }];
}


- (void)handleNextButton {
    
    [self returnKeyBoard];
    
    ZLLog(@"next %@ %@", self.phoneTextField.text, self.captchaTextField.text);
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    params[@"phone"] = [self.phoneTextField.text trim];
    params[@"code"]  = [self.captchaTextField.text trim];
    
    weakSelf(self);
    [self setNextButtonEnabled:NO];
    [UserRequest loginWithParams:params success:^(TMUserInfoResultModel *resultModel) {
        
        strongSelf(self);
        [self setNextButtonEnabled:YES];
        
        TMUserInfoModel *model = resultModel.user;
        [UserInfoService shareUserInfo].userInfo.userId = model.userId;
        [UserInfoService shareUserInfo].userInfo.name = model.name;
        [UserInfoService shareUserInfo].userInfo.avatar = model.avatar;
        [UserInfoService shareUserInfo].userInfo.phone = model.phone;
        [UserInfoService shareUserInfo].userInfo.sign = model.sign;
        [UserInfoService shareUserInfo].userInfo.gender = model.gender;
        [UserInfoService shareUserInfo].userInfo.isLogin = YES;
        [[UserInfoService shareUserInfo] loginAndSaveData];
        
        [self showNotice:@"登录成功"];
        
        [self navigationBackAction];
        
        NSMutableDictionary *p = [NSMutableDictionary dictionary];
        params[@"deviceToken"] = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
        [UserRequest uploadPushTokenWithParams:p success:^{
            NSLog(@"success upload");
            [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"lastUploadToken"];
        } failure:^(StatusModel *status) {
            NSLog(@"failed upload");
            [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"lastUploadToken"];
        }];
        
    } failure:^(StatusModel *status) {
        [self setNextButtonEnabled:YES];
        if(status) {
            strongSelf(self);
            if (status.code == StatusCodeUnregistered) {
                ZLNavigationController *navigationController = [[ApplicationEntity shareInstance] currentNavigationController];
//                RegisterStepTwoViewController *vc = [[RegisterStepTwoViewController alloc] init];
//                vc.phone = [self.phoneTextField.text trim];
//                vc.code = [self.captchaTextField.text trim];
//                [navigationController pushViewController:vc animated:YES];
            }else
                [self showNotice:status.msg];
        } else {
            [self showNotice:@"登录失败"];
        }
    }];
}

#pragma mark - third part login delegate
- (void)wechatAuthorizeLogin {}
- (void)weiboAuthorizeLogin {}
- (void)tencentAuthorizeLogin {}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *phoneText = self.phoneTextField.text;
    NSString *captchaText = self.captchaTextField.text;
    
    if (textField == self.phoneTextField) {
        phoneText = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
    } else if ( textField == self.captchaTextField ) {
        captchaText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    }
    
    if (![phoneText isEmptyString] && ![captchaText isEmptyString]) {
        [self setNextButtonEnabled:YES];
    } else {
        [self setNextButtonEnabled:NO];
    }
    return YES;
}

- (void)setCaptchaButtonEnabled:(BOOL)enabled {
    if (enabled) {
        self.captchaButton.enabled = YES;
        self.captchaButton.backgroundColor = ZLRedColor;
    } else {
        self.captchaButton.enabled = NO;
        self.captchaButton.backgroundColor = ZLGray(235);
    }
}

- (void)setNextButtonEnabled:(BOOL)enabled {
    if (enabled) {
        self.nextButton.enabled = YES;
        self.nextButton.backgroundColor = ZLRedColor;
    } else {
        self.nextButton.enabled = NO;
        self.nextButton.backgroundColor = ZLGray(235);
    }
}

- (void)returnKeyBoard {
    [self.phoneTextField resignFirstResponder];
    [self.captchaTextField resignFirstResponder];
}


@end
