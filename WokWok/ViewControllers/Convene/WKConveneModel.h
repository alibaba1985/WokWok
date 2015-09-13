//
//  WKConveneModel.h
//  WokWok
//
//  Created by 王坜 on 15/9/9.
//  Copyright (c) 2015年 王坜. All rights reserved.
//

#import "JSONModel.h"

@interface WKConveneModel : JSONModel

@property (nonatomic, strong) NSString *userIcon;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userSexy;
@property (nonatomic, strong) NSString *userSay;
@property (nonatomic, strong) NSArray *userImages;
@property (nonatomic, strong) NSArray *chatUsers;
@property (nonatomic, strong) NSString *chatUserNum;
@property (nonatomic, strong) NSArray *marks;
@property (nonatomic, strong) NSString *localDesc;
@property (nonatomic, strong) NSString *timestamp;
@property (nonatomic, strong) NSString *userAge;



@end
