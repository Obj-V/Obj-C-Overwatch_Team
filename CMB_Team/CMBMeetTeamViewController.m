//
//  CMBMeetTeamViewController.m
//  CMB_Team
//
//  Created by Virata Yindeeyoungyeon on 4/1/17.
//  Copyright © 2017 ObjV. All rights reserved.
//

#import "CMBMeetTeamViewController.h"
#import "CMBMeetTeamStretchedHeaderView.h"
#import "CMBMeetTeamTableViewCell.h"
#import "CMBMeetTeamDetailViewController.h"
#import "CMBMeetTeamModel.h"

static NSString *kCellID = @"CMBMeetTeamCell";
static CGFloat kTableViewHeaderHeight;
static CGRect kTableViewHeaderFrame;
static CGFloat kTableViewRowHeight;

@interface CMBMeetTeamViewController () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) CMBMeetTeamStretchedHeaderView *stretchedHeaderView;
@property (nonatomic,strong) NSArray *teamMemberArray;
@end

@implementation CMBMeetTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupVars];
    [self setupTableView];
    [self setupStretchedHeaderView];
    
    self.teamMemberArray = [[CMBMeetTeamModel sharedInstance] allTeamMembers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupVars {
    kTableViewHeaderHeight = self.view.bounds.size.height/3;
    kTableViewHeaderFrame = CGRectMake(0, -kTableViewHeaderHeight, self.view.bounds.size.width, kTableViewHeaderHeight);
    kTableViewRowHeight = self.view.bounds.size.height/8;
}

#pragma mark TableView
- (void)setupTableView {
    self.tableview = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.allowsMultipleSelection = NO;
    self.tableview.allowsSelectionDuringEditing = NO;
    self.tableview.showsVerticalScrollIndicator = NO;
    [self.tableview registerClass:[CMBMeetTeamTableViewCell class] forCellReuseIdentifier:kCellID];
    [self.view addSubview:self.tableview];
}

#pragma mark StretchedHeaderView
- (void)setupStretchedHeaderView {
    self.tableview.tableHeaderView = nil;
    self.tableview.tableFooterView = [[UIView alloc] init];
    self.tableview.contentInset = UIEdgeInsetsMake(kTableViewHeaderHeight, 0, 0, 0);
    self.tableview.contentOffset = CGPointMake(0, -kTableViewHeaderHeight);
    self.stretchedHeaderView = [[CMBMeetTeamStretchedHeaderView alloc] initWithFrame:kTableViewHeaderFrame];
    [self.tableview addSubview:self.stretchedHeaderView];
}

- (void)updateStretchedHeaderView {
    CGRect headerFrame = kTableViewHeaderFrame;
    if (self.tableview.contentOffset.y < -kTableViewHeaderHeight) {
        headerFrame.origin.y = self.tableview.contentOffset.y;
        headerFrame.size.height = -self.tableview.contentOffset.y;
    }
    self.stretchedHeaderView.frame = headerFrame;
}

#pragma mark UITableViewDelegate,UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.teamMemberArray.count;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    CMBMeetTeamMember *teamMember = self.teamMemberArray[indexPath.row];
    if (!teamMember.isVisited) { //Only animate the cells that hasn't seen before.
        CGAffineTransform tranform = CGAffineTransformMakeTranslation(-tableView.bounds.size.width, 0);
        cell.transform = tranform;
        [UIView animateWithDuration:0.4 animations:^{
            cell.transform = CGAffineTransformIdentity;
        }];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMBMeetTeamMember *teamMember = self.teamMemberArray[indexPath.row];
    CMBMeetTeamTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    cell.teamMember = teamMember;
    return cell;
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    CMBMeetTeamMember *teamMember = self.teamMemberArray[indexPath.row];
    teamMember.isVisited = YES;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kTableViewHeaderHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    CMBMeetTeamMember *teamMember = self.teamMemberArray[indexPath.row];
    CMBMeetTeamDetailViewController *detailVC = [[CMBMeetTeamDetailViewController alloc] initWithTeamMember:teamMember];
    [self presentViewController:detailVC animated:YES completion:nil];
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateStretchedHeaderView];
}

@end
