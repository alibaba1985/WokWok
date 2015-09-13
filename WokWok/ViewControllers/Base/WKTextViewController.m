//
//  WKTextViewController.m
//  WokWok
//
//  Created by 王坜 on 15/8/16.
//  Copyright (c) 2015年 王坜. All rights reserved.
//

#import "WKTextViewController.h"

@interface WKTextViewController ()
{
    UITextField *_onFocusedTextField;
    BOOL _keyboardWillHidden;
}



@end

@implementation WKTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UPKeyboard Delegate

- (void)keyBoardWillChangeFrame:(NSNotification *)notification
{
    if (_keyboardWillHidden && _onFocusedTextField == nil) {
        return;
    }
    // step 1: get keyboard height
    NSValue *keyboardRectValue = [notification userInfo][UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [keyboardRectValue CGRectValue];
    CGFloat keyboardHeight = MIN(CGRectGetHeight(keyboardRect), CGRectGetWidth(keyboardRect));
    NSValue *animationDurationValue = [notification userInfo][UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    // Step 2: 重新设定 scrollView 的大小
    CGRect newFrame = self.contentView.frame;
    newFrame.size.height = self.contentHeight - keyboardHeight;
    
    [UIView beginAnimations:@"keyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    self.contentView.frame = newFrame;
    [UIView commitAnimations];
    
    // Step 3：将被挡住的部分滚动显示出来
    
    CGRect textFieldFrame = [_onFocusedTextField frame];
    CGRect frame = [_onFocusedTextField convertRect:textFieldFrame toView:self.contentView];
    [self.contentView scrollRectToVisible:frame animated:YES];
}


-(void)keyboareWillHide:(NSNotification*)aNotification
{
    NSValue *animationDurationValue = [aNotification userInfo][UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    [UIView beginAnimations:@"keyboard" context:nil];
    self.contentView.frame = self.contentOriginalFrame;
    [UIView setAnimationDuration:animationDuration];
    [UIView commitAnimations];
    
}

#pragma mark - UITextFieldDelegate


- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    _onFocusedTextField = nil;
    _keyboardWillHidden = YES;
    return YES;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _keyboardWillHidden = NO;
    _onFocusedTextField = textField;
}



- (void)checkTextFieldClear:(UITextField *)textField
{

}



- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}




@end
