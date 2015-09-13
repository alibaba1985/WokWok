//
//  WKConveneListViewController.m
//  WokWok
//
//  Created by 王坜 on 15/9/7.
//  Copyright (c) 2015年 王坜. All rights reserved.
//

#import "WKConveneListViewController.h"
#import "WKConveneCell.h"
#import "WKConveneModel.h"

@interface WKConveneListViewController ()

@property (nonatomic, strong) NSMutableArray *conveneModels;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation WKConveneListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setCustomNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor whiteColor];
    [self makeDatas];
    [self makeTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)makeDatas
{
    self.conveneModels = [[NSMutableArray alloc] init];
    
    NSString *url = @"https://tse1-mm.cn.bing.net/th?id=JN.ZRGgDZPBbLrhvVdQ9Mzj8A&w=125&h=105&c=7&rs=1&qlt=90&pid=3.1&rm=2";
    
    WKConveneModel *model = [[WKConveneModel alloc] init];
    
    model.userAge = @"22";
    model.userIcon = url;
    model.userName = @"王俊宇";
    model.timestamp = @"30分钟前";

    model.localDesc = @"出发地 上海";
    model.marks = @[@"旅游", @"西藏"];
    model.userSay = @"好帅啊好帅啊好帅啊好帅啊好帅啊好帅啊好帅啊好帅啊好帅啊好帅啊好帅啊好帅啊好帅啊好帅啊好帅啊好帅啊好帅啊好帅啊好帅啊好帅啊好帅啊好帅啊好帅啊好帅啊好帅啊好帅啊好帅啊";
    model.userImages = @[url, url, url];
    model.userSexy = @"2";
    
    for (NSInteger i = 0; i < 10; i++) {
        [self.conveneModels addObject:model];
    }
}


#pragma mark - make table

- (void)makeTableView
{
    self.tableView = ({
        CGRect frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        
        tableView;
    });
    
    [self.view addSubview:self.tableView];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return self.conveneModels.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WKConveneModel *model = [self.conveneModels objectAtIndex:indexPath.row];
    return [WKConveneCell calculateCellHeightWithModel:model];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"reuseIdentifier";
    
    WKConveneCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    // Configure the cell...
    if (!cell) {
        cell = [[WKConveneCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    WKConveneModel *model = [self.conveneModels objectAtIndex:indexPath.row];
    
    [cell rebuildCellWithModel:model];
    
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}


// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


@end
