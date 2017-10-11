//
//  SettingController.m
//  ZLBaseProject
//
//  Created by LayZhang on 2017/10/10.
//  Copyright © 2017年 Zhanglei. All rights reserved.
//

#import "SettingController.h"

#import "TMSettingCell.h"
#import "TMSingleCell.h"

#import "MineRequest.h"

@interface SettingController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSArray *menu;

@end

@implementation SettingController

- (void)viewDidLoad {
    self.scrollViewRefreshType = ScrollViewRefreshTypeNone;
    [super viewDidLoad];
 
    self.view.backgroundColor = ZLGray(245);
    
    self.title = @"设置";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initData];
}

- (void)initData {
    [self loadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (1 == section) {
        return 1;
    }
    
    return self.menu.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (1 == indexPath.section) {
        TMSingleCell *cell = [TMSingleCell dequeueReusableCellForTableView:tableView];
        return cell;
    }
    
    NSDictionary *itemData = self.menu[indexPath.row];
    
    if (![@"empty" isEqualToString:itemData[@"type"]]) {
        TMSettingCell *cell = [TMSettingCell dequeueReusableCellForTableView:tableView];
        cell.cellData = itemData;
        return cell;
    }
    
    BaseTableCell *cell = [BaseTableCell dequeueReusableCellForTableView:tableView];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;

    if (1 == indexPath.section) {
        height = [[TMSingleCell heightForCell:nil] floatValue];
    } else {
        height = [[TMSettingCell heightForCell:self.menu[indexPath.row]] floatValue];
    }
    
    return height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section) {
        NSDictionary *itemData = self.menu[indexPath.row];
        
        if ([@"avatar" isEqualToString:itemData[@"type"]]) {
            
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择头像来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从手机相册选取", nil];
            actionSheet.tag = 1;
            [actionSheet showInView:self.view];
            
        } else if ([@"name" isEqualToString:itemData[@"type"]]) {
            
            [[ZLNavigationService sharedService] openUrl:LocalAppHost(ChangeNick)];
            
        } else if ([@"gender" isEqualToString:itemData[@"type"]]) {
            
            [[ZLNavigationService sharedService] openUrl:LocalAppHost(ChangeGender)];
            
        }else if ([@"consignee" isEqualToString:itemData[@"type"]]) {
            
//            [[TTNavigationService sharedService] openUrl:LOCALSCHEMA(@"consigneeSelect")];
            
        }else if ([@"contact" isEqualToString:itemData[@"type"]]) {
            NSString *supportLink = [[NSUserDefaults standardUserDefaults] objectForKey:@"supportLink"];
            [[ZLNavigationService sharedService] openUrl:supportLink];
            
        }else if ([@"about" isEqualToString:itemData[@"type"]]) {
            
            NSString *aboutLink = [[NSUserDefaults standardUserDefaults] objectForKey:@"aboutLink"];
            [[ZLNavigationService sharedService] openUrl:aboutLink];
            
        }else if ([@"protocol" isEqualToString:itemData[@"type"]]) {
            
            NSString *protocolLink = [[NSUserDefaults standardUserDefaults] objectForKey:@"protocolLink"];
            [[ZLNavigationService sharedService] openUrl:protocolLink];
        }
    }
}

#pragma mark - action sheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self avatarFromSourceType:UIImagePickerControllerSourceTypeCamera];
            break;
        case 1: // 从手机相册选取
            [self avatarFromSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
            break;
        default:
            break;
    }
}

#pragma mark - pick image
- (void)avatarFromSourceType:(UIImagePickerControllerSourceType)sourceType {
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = sourceType;
        imagePicker.allowsEditing = YES;
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeImage]){
        
        UIImage *avatarImage = [info objectForKey:UIImagePickerControllerEditedImage];
        
        weakSelf(self);
        [MineRequest changeAvatarWithParams:nil image:avatarImage success:^(TMChangeAvatarResultModel *resultModel){
            
            [UserInfoService shareUserInfo].userInfo.avatar = resultModel.avatar;;
            [[UserInfoService shareUserInfo] saveData];
            
            strongSelf(self);
            [self reloadData];
            
        } failure:^(StatusModel *status) {
            [self showNotice:status.msg];
        }];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - failed and reload deleaget
- (void)failedViewBeginReload:(ZLFailedAndReloadView *)reloadView {
    NSLog(@"reoload data here!!!");
    [self loadData];
}

#pragma mark - header and footer refresh
- (void)willRefresh {
    [super willRefresh];
    [self loadData];
}

- (void)willLoadMore {
    [super willLoadMore];
    [self didLoadMore];
}

- (void)loadData {
    self.menu = @[
                  @{@"type":@"avatar", @"title":@"头像", @"line":@YES, @"arrow":@YES},
                  @{@"type":@"name", @"title":@"昵称", @"line":@YES, @"arrow":@YES},
                  @{@"type":@"gender", @"title":@"性别", @"line":@NO, @"arrow":@YES},
                  @{@"type":@"empty"},
                  @{@"type":@"consignee", @"title":@"管理收货地址", @"line":@YES, @"arrow":@YES},
                  @{@"type":@"empty"},
                  @{@"type":@"contact", @"title":@"联系我们", @"line":@YES, @"arrow":@YES},
                  @{@"type":@"about", @"title":@"关于我们", @"line":@YES, @"arrow":@YES},
                  @{@"type":@"protocol", @"title":@"用户协议", @"line":@YES, @"arrow":@YES}
                  ];
    [self reloadData];
}
@end
