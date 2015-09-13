//
//  WKConveneCell.h
//  WokWok
//
//  Created by 王坜 on 15/9/9.
//  Copyright (c) 2015年 王坜. All rights reserved.
//

#import <UIKit/UIKit.h>




@class WKConveneModel;

@interface WKConveneCell : UITableViewCell

@property (nonatomic, readonly) UIImageView *userIcon;

@property (nonatomic, readonly) UPLabel *userNameLabel;

@property (nonatomic, readonly) UPLabel *userSayLabel;

@property (nonatomic, readonly) UPLabel *locationLabel;

@property (nonatomic, assign) WKUserSex userSex;



+ (CGFloat)calculateCellHeightWithModel:(WKConveneModel *)model;

- (void)rebuildCellWithModel:(WKConveneModel *)model;




@end
