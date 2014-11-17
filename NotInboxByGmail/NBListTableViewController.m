//
//  NBListTableViewController.m
//  NotInboxByGmail
//
//  Created by Nia Mutiara on 9/11/14.
//  Copyright (c) 2014 CatCyborg. All rights reserved.
//

#import "UIView+Screenshot.h"
#import "NBContainerViewController.h"
#import "NBDetailListContainerViewController.h"
#import "NBListTableViewController.h"

@interface NBListTableViewController ()
@property (strong, nonatomic) NSIndexPath *expandedIndexPath;
@end

@implementation NBListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(didTapClose:)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)didTapClose:(id)sender
{
    [(NBDetailListContainerViewController *)self.parentViewController.parentViewController dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Some day %ld", (long)section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NBTableViewCell" forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.expandedIndexPath isEqual:indexPath]) {
        return self.view.frame.size.height-2;
    }
    return 92;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    CGPoint point = [self.parentViewController.view convertPoint:cell.frame.origin fromView:tableView];
    CGRect originRect = (CGRect){point.x, point.y, cell.frame.size.width, cell.frame.size.height};

    NBDetailListContainerViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"NBDetailListContainerViewController"];
    vc.originRect = originRect;
    vc.animatingImage = [self.parentViewController.view takeScreenshot];
    vc.view.translatesAutoresizingMaskIntoConstraints = NO;
    [vc showInViewController:self.navigationController.parentViewController];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    /*
     Did select:
     1. Take screenshot and set to the child view controller
     2. Animate split, make sure background color is white and also animating together
     3. When top screenshot is close to the top, animate alpha of the detail view
     4. For previous and next, pass the whole list
     they probably morph together just like in facebook paper
     
     Pull:
     1. Anchor point of morphing to the child view controller's navigation bar
     2. Symmetrically do reverse did select
     */
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];
}

@end
