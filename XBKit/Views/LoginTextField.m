//
//  LoginTextField.m
//  XJPH
//
//  Created by Xinbo Hong on 2018/6/12.
//  Copyright © 2018年 Xinbo. All rights reserved.
//

#import "LoginTextField.h"
#import <Masonry.h>
@interface LoginTextField ()<UITextFieldDelegate>

@property (nonatomic, strong) NSString *placeholderStr;

@property (nonatomic, strong) NSString *titleStr;

@property (nonatomic, strong) NSString *buttonImageName;

@end

@implementation LoginTextField

- (instancetype)init {
    self = [super init];
    if (self) {
        
        [self addSubview:self.inputTextField];
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.rightButton];
        [self addSubview:self.bottomLine];
    
    }
    return self;
}

- (void)layoutSubviews {
    [self setNeedsLayout];
    
    [self setupMasonry];
}

- (void)changeTitle:(NSString *)title titleColor:(UIColor *)color {
    if (title) {
        self.titleLabel.text = title;
    }
    if (color) {
        self.titleLabel.textColor = color;
    }
}

- (void)setBasePropertyWithTitle:(NSString *)title
                     placeholder:(NSString *)placeholder
                  rightImageName:(NSString *)imageName
               rightButtonAction:(rightButtoAction)block{
    if (title) {
        self.titleStr = title;
    }
    if (placeholder) {
        self.placeholderStr = placeholder;
    }
    if (imageName) {
        self.buttonImageName = imageName;
        [self.rightButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        if ([imageName isEqualToString:@"login_delete"]) {
            self.rightButton.hidden = true;
        }
    }
    if (block) {
        self.blockAction = block;
    }
    //默认
    self.titleLabel.text = self.placeholderStr;

}

- (void)setTitleLabelStatus:(NSString *)status {
    //0代表placeholder，1代表标题
    if ([status isEqualToString:@"0"]) {
        self.titleLabel.text = self.placeholderStr;
        self.titleLabel.font = [UIFont fontWithName:kMediumPingFang() autoSize:15.0];
        self.titleLabel.textColor = [UIColor colorWithWhite:170.0 / 255.0 alpha:1.0f];
        [UIView animateWithDuration:0.25 animations:^{
            [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.inputTextField.mas_centerY).offset(-20);
            }];
            
            [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.inputTextField.mas_centerY);
            }];
            [self.titleLabel.superview layoutIfNeeded];
        }];
    } else {
        self.titleLabel.font = [UIFont fontWithName:kRegularPingFang() autoSize:13.0];
        self.titleLabel.textColor = [UIColor colorWithWhite:153.0 / 255.0 alpha:1.0f];
        self.titleLabel.text = self.titleStr;
        [UIView animateWithDuration:0.25 animations:^{
            [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self.inputTextField.mas_centerY).offset(-20);
            }];
            [self.titleLabel.superview layoutIfNeeded];
        }];
    }
}


- (void)titleLabelTapInLoginTextField:(UITapGestureRecognizer *)sender {
    [self.inputTextField becomeFirstResponder];
    [self setTitleLabelStatus:@"1"];
}

- (void)textFieldValueChangeInLoginTextField:(UITextField *)sender {
    if (sender.text.length > 0 && [self.buttonImageName isEqualToString:@"login_delete"]) {
        self.rightButton.hidden = false;
    } else if (sender.text.length == 0 && [self.buttonImageName isEqualToString:@"login_delete"]) {
        self.rightButton.hidden = true;
    }
}

- (void)rightButtonActionInLoginTextField:(UIButton *)sender {
    if (self.blockAction) {
        self.blockAction(sender);
    }
}

#pragma mark - **************** UITextField Delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length == 0) {
        [self setTitleLabelStatus:@"0"];
    }
    if (textField.text.length == 0 && [self.buttonImageName isEqualToString:@"login_delete"]) {
        self.rightButton.hidden = true;
    }
    
}

#pragma mark - **************** frame
- (void)setupMasonry {
    
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.mas_equalTo(25);
        make.bottom.equalTo(self);
    }];
    
    //默认覆盖inputTextField
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.inputTextField);
        make.centerX.equalTo(self.inputTextField.mas_centerX);
        make.centerY.equalTo(self.inputTextField.mas_centerY);
        make.height.equalTo(self.inputTextField.mas_height);
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.left.equalTo(self.mas_right).offset(-30);
        make.centerY.equalTo(self.inputTextField.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.inputTextField.mas_bottom).offset(-1);
        make.height.mas_equalTo(1);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.userInteractionEnabled = true;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(titleLabelTapInLoginTextField:)];
        [self.titleLabel addGestureRecognizer:tap];
        
        //默认设置
        self.titleLabel.font = [UIFont fontWithName:kMediumPingFang() autoSize:15.0];
        self.titleLabel.textColor = [UIColor colorWithWhite:170.0 / 255.0 alpha:1.0f];
    }
    return _titleLabel;
}

- (UITextField *)inputTextField {
    if (!_inputTextField) {
        self.inputTextField = [[UITextField alloc] init];
        self.inputTextField.font = [UIFont fontWithName:kMediumPingFang() autoSize:15.0f];
        self.inputTextField.textColor = [UIColor colorWithWhite:34.0 / 255.0 alpha:1.0f];
        self.inputTextField.delegate = self;
        [self.inputTextField addTarget:self action:@selector(textFieldValueChangeInLoginTextField:) forControlEvents:UIControlEventEditingChanged];
    }
    return _inputTextField;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        self.rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.rightButton addTarget:self action:@selector(rightButtonActionInLoginTextField:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        self.bottomLine = [[UIView alloc] init];
        self.bottomLine.backgroundColor = [UIColor grayColor];
    }
    return _bottomLine;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
