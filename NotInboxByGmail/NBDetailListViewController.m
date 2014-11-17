//
//  NBDetailListViewController.m
//  NotInboxByGmail
//
//  Created by Nia Mutiara on 13/11/14.
//  Copyright (c) 2014 CatCyborg. All rights reserved.
//

#import "NBDetailListContainerViewController.h"
#import "NBDetailListViewController.h"

@implementation NBDetailListViewController

- (IBAction)didTapClose:(id)sender
{
    [(NBDetailListContainerViewController *)self.parentViewController.parentViewController dismiss];
}

@end
