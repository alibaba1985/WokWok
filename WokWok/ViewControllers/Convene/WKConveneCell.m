//
//  WKConveneCell.m
//  WokWok
//
//  Created by 王坜 on 15/9/9.
//  Copyright (c) 2015年 王坜. All rights reserved.
//

#import "WKConveneCell.h"
#import "WKConveneModel.h"
#import "UIImageView+WebCache.h"


#define kIconSize         35

#define kCommonSize       16

#define kLocationSize     14

#define kMarkSize         20

#define kImageWidth       135
#define kImageHeight      90
#define kChatBarHeight    60
#define kChatIconSize     25



@interface WKConveneCell ()
{
    UIImageView *_userIcon;
    UPLabel *_userNameLabel;
    UPLabel *_userSayLabel;
    UPLabel *_locationLabel;
    
    
    UIScrollView *_imageScrollView;
    
    UIView *_conveneView;
    
    CGFloat _originalX;
    CGFloat _originalY;
    CGFloat _cellHeight;
    
    CGFloat _userSayWidth;
}
@property (nonatomic, strong) WKConveneModel *conveneModel;

@end

@implementation WKConveneCell
@synthesize userIcon = _userIcon;
@synthesize userNameLabel = _userNameLabel;
@synthesize userSayLabel = _userSayLabel;
@synthesize locationLabel = _locationLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



+ (CGFloat)calculateCellHeightWithModel:(WKConveneModel *)model
{
    CGFloat height = kMargin_10 * 2 + kIconSize;
    
    if (!UtilIsNilOrEmptyString(model.userSay)) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width - kMargin_10*3 - kIconSize;
        CGSize size = [model.userSay sizeWithFontSize:kCommonSize forWidth:width];
        
        height += size.height + kMargin_10;
    }
    
    if (model.userImages) {
        height += (kMargin_10 + kImageHeight);
    }
    
    if (!UtilIsNilOrEmptyString(model.localDesc) || !UtilIsNilOrEmptyArray(model.marks)) {
        height += (kMargin_10 + kMarkSize);
    }
    
    if (!UtilIsNilOrEmptyString(model.chatUserNum) || !UtilIsNilOrEmptyArray(model.chatUsers)) {
        height += kChatBarHeight;
    }
    
    return height;
}


- (CGFloat)conveneViewHeightWithModel:(WKConveneModel *)model
{
    CGFloat height = kMargin_10 * 2 + kIconSize;
    
    if (!UtilIsNilOrEmptyString(model.userSay)) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width - kMargin_10*3 + kIconSize;
        CGSize size = [model.userSay sizeWithFontSize:kCommonSize forWidth:width];
        
        height += size.height + kMargin_10;
    }
    
    if (model.userImages) {
        height += (kMargin_10 + kImageHeight);
    }
    
    if (!UtilIsNilOrEmptyString(model.localDesc) || !UtilIsNilOrEmptyArray(model.marks)) {
        height += (kMargin_10 + kMarkSize);
    }
    
    return height;
}


- (void)removeAllSubviews
{
    for (UIView *view in self.contentView.subviews) {
        UtilRemoveView(view);
    }
}


- (void)makeDefaultData
{
    _userSayWidth = kScreenWidth - kMargin_10*3 - kIconSize;
}

- (void)rebuildCellWithModel:(WKConveneModel *)model
{
    self.contentView.clipsToBounds = YES;
    self.conveneModel = model;
    [self removeAllSubviews];
    [self makeDefaultData];
    [self makeConveneView];
    [self makeUserIcon];
    [self makeUserName];
    [self makeUserSex];
    [self makeTimestamp];
    [self makeUserSay];
    [self makeImageScrollView];
    [self makeLocalDesc];
    [self makeMarks];
    [self makeChatUsers];
}


- (void)makeConveneView
{
    CGFloat height = [self conveneViewHeightWithModel:self.conveneModel];
    _conveneView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, height)];
    _conveneView.backgroundColor = Color_White;
    [self.contentView addSubview:_conveneView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
    line.backgroundColor = Color_LightGray;
    [_conveneView addSubview:line];
}

- (void)makeUserIcon
{
    
    _userIcon = [[UIImageView alloc] initWithFrame:CGRectMake(kMargin_10, kMargin_10, kIconSize, kIconSize)];
    _userIcon.layer.masksToBounds = YES;
    _userIcon.layer.borderColor = [UIColor colorWithWhite:0.6 alpha:0.6].CGColor;
    _userIcon.layer.cornerRadius = kIconSize / 2;
    [_conveneView addSubview:_userIcon];
    
    if (!UtilIsNilOrEmptyString(self.conveneModel.userIcon)) {
        [_userIcon sd_setImageWithURL:[NSURL URLWithString:self.conveneModel.userIcon]];
    }
    
    _originalX = kMargin_10 * 2 + kIconSize;
    _originalY = kMargin_10;
}

- (void)makeUserName
{
    if (UtilIsNilOrEmptyString(self.conveneModel.userName)) {
        return;
    }
    
    CGRect frame = CGRectMake(_originalX, kMargin_10, _userSayWidth, kIconSize/2);
    _userNameLabel = [AIViews normalLabelWithFrame:frame text:self.conveneModel.userName fontSize:kCommonSize color:Color_CommonText];
    _userNameLabel.verticalAlignment = UPVerticalAlignmentTop;
    [_conveneView addSubview:_userNameLabel];
    
}

- (void)makeUserSex
{
    if (UtilIsNilOrEmptyString(self.conveneModel.userSexy)) {
        return;
    }
    
    CGSize size = [self.conveneModel.userAge sizeWithFontSize:12 forWidth:50];
    CGFloat y = kMargin_10 + kIconSize/2 + kMargin_5;
    UIView *sexView = [[UIView alloc] initWithFrame:CGRectMake(_originalX, y, size.width + kMargin_5 * 2, kIconSize/2 - kMargin_5)];
    sexView.layer.cornerRadius = 2;
    [_conveneView addSubview:sexView];
    
    if ([self.conveneModel.userSexy isEqualToString:@"0"]) {
        sexView.backgroundColor = [UIColor lightGrayColor];
    }
    else if ([self.conveneModel.userSexy isEqualToString:@"1"]) {
        sexView.backgroundColor = [UIColor blueColor];
    }
    else if ([self.conveneModel.userSexy isEqualToString:@"2"]) {
        sexView.backgroundColor = [UIColor redColor];
    }
    
    
    CGRect ageFrame = CGRectMake(kMargin_5, 0, size.width, kIconSize/2 - kMargin_5);
    
    UPLabel *ageLabel = [AIViews normalLabelWithFrame:ageFrame text:self.conveneModel.userAge fontSize:11 color:Color_White];
    [sexView addSubview:ageLabel];
}

- (void)makeTimestamp
{
    if (UtilIsNilOrEmptyString(self.conveneModel.timestamp)) {
        return;
    }
    UPLabel *timeLabel = [AIViews normalLabelWithFrame:_userNameLabel.frame text:self.conveneModel.timestamp fontSize:kLocationSize color:Color_LightGray];
    timeLabel.textAlignment = NSTextAlignmentRight;
    [_conveneView addSubview:timeLabel];
}

- (void)makeUserSay
{
    if (UtilIsNilOrEmptyString(self.conveneModel.userSay)) {
        return;
    }
    
    _originalY = kMargin_10*2 + kIconSize;
    CGSize size = [self.conveneModel.userSay sizeWithFontSize:kCommonSize forWidth:_userSayWidth];
    CGRect frame = CGRectMake(_originalX, _originalY, _userSayWidth, size.height);
    _userSayLabel = [AIViews normalLabelWithFrame:frame text:self.conveneModel.userSay fontSize:kCommonSize color:Color_CommonText];
    _userSayLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _userSayLabel.numberOfLines = 0;
    [_conveneView addSubview:_userSayLabel];
    _originalY += size.height + kMargin_10;
}

- (void)makeImageScrollView
{
    if (UtilIsNilOrEmptyArray(self.conveneModel.userImages)) {
        return;
    }
    
    CGRect sFrame = CGRectMake(_originalX, _originalY, _userSayWidth, kImageHeight);
    _imageScrollView = [[UIScrollView alloc] initWithFrame:sFrame];
    _imageScrollView.scrollEnabled = NO;
    [_conveneView addSubview:_imageScrollView];
    
    CGFloat x = 0;
    for (NSInteger i = 0; i < self.conveneModel.userImages.count; i++) {
        CGRect iFrame = CGRectMake(x, 0, kImageWidth, kImageHeight);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:iFrame];
        NSString *url = [self.conveneModel.userImages objectAtIndex:i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:url]];
        [_imageScrollView addSubview:imageView];
        
        x += (kImageWidth + kMargin_10);
    }
    
    _originalY += (kImageHeight + kMargin_10);
}

- (void)makeMarks
{
    if (UtilIsNilOrEmptyArray(self.conveneModel.marks)) {
        return;
    }
    
    UIView *markView = [[UIView alloc] initWithFrame:CGRectZero];
    [_conveneView addSubview:markView];
    
    CGFloat x = 0;
    for (NSString *mark in self.conveneModel.marks) {
        CGSize size = [mark sizeWithFontSize:kLocationSize forWidth:100];
        UPLabel *label = [AIViews normalLabelWithFrame:CGRectMake(x, 0, size.width + kMargin_5*2, kMarkSize) text:mark fontSize:kLocationSize color:Color_Red];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.borderColor = Color_Red.CGColor;
        label.layer.borderWidth = 1;
        label.layer.cornerRadius = kMarkSize/2;
        [markView addSubview:label];
        
        x += (size.width + kMargin_5*3);
    }
    
    x -= kMargin_5;
    markView.frame = CGRectMake(kScreenWidth-kMargin_10-x, _originalY, x, kMarkSize);
    
    
    
}

- (void)makeLocalDesc
{
    if (UtilIsNilOrEmptyString(self.conveneModel.localDesc)) {
        return;
    }
    
    CGRect frame = CGRectMake(_originalX, _originalY, _userSayWidth, kMarkSize);
    _locationLabel = [AIViews normalLabelWithFrame:frame text:self.conveneModel.localDesc fontSize:kLocationSize color:Color_LightGray];
    [_conveneView addSubview:_locationLabel];
}

- (void)makeChatUsers
{
    
}


@end
