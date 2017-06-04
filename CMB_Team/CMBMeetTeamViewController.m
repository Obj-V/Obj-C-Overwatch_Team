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
#import "CMBMeetTeamNetworkManager.h"
#import "CMBMeetTeamViewModel.h"

static CGFloat kTableViewHeaderHeight;
static CGRect kTableViewHeaderFrame;
static CGFloat kTableViewRowHeight;

@interface CMBMeetTeamViewController () <UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) CMBMeetTeamStretchedHeaderView *stretchedHeaderView;
@property (nonatomic,strong) NSArray *teamViewModelArray;
@end

@implementation CMBMeetTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupVars];
    [self setupTableView];
    [self setupStretchedHeaderView];
    [self setupTeamMembers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setupVars {
    kTableViewHeaderHeight = self.view.bounds.size.height/3;
    kTableViewHeaderFrame = CGRectMake(0, -kTableViewHeaderHeight, self.view.bounds.size.width, kTableViewHeaderHeight);
    kTableViewRowHeight = self.view.bounds.size.height/8;
}

- (void)setupTeamMembers {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"team" ofType:@"json"];
    [CMBMeetTeamNetworkManager loadTeamDataWithPath:filePath completion:^(NSArray *dataArray) {
        self.teamViewModelArray = [CMBMeetTeamViewModel teamViewModelArrayFromTeamModelArray:dataArray];
        NSLog(@"%@", self.teamViewModelArray);
        [self.tableview reloadData];
    }];
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
    [self.tableview registerClass:[CMBMeetTeamTableViewCell class] forCellReuseIdentifier:kMeetTeamCellID];
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
    return self.teamViewModelArray.count;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    CMBMeetTeamViewModel *teamMember = self.teamViewModelArray[indexPath.row];
    if (!teamMember.isVisited) { //Only animate the cells that hasn't seen before.
        CGAffineTransform tranform = CGAffineTransformMakeTranslation(-tableView.bounds.size.width, 0);
        cell.transform = tranform;
        [UIView animateWithDuration:0.4 animations:^{
            cell.transform = CGAffineTransformIdentity;
        }];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMBMeetTeamViewModel *teamModelView = self.teamViewModelArray[indexPath.row];
    CMBMeetTeamTableViewCell *cell = [teamModelView cellInstance:tableView indexPath:indexPath];
    return cell;
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    CMBMeetTeamViewModel *teamViewModel = self.teamViewModelArray[indexPath.row];
    [teamViewModel resetCellInstanceAfterShown];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kTableViewHeaderHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    CMBMeetTeamViewModel *teamViewModel = self.teamViewModelArray[indexPath.row];
    CMBMeetTeamDetailViewController *detailVC = [[CMBMeetTeamDetailViewController alloc] initWithTeamViewModel:teamViewModel];
    [self presentViewController:detailVC animated:YES completion:nil];
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateStretchedHeaderView];
}

@end
