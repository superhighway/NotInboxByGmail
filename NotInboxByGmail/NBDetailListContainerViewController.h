//
//  NBDetailListContainerViewController.h
//  NotInboxByGmail
//
//  Created by Nia Mutiara on 13/11/14.
//  Copyright (c) 2014 CatCyborg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBDetailListContainerViewController : UIViewController
@property (nonatomic) CGRect originRect;
@property (strong, nonatomic) UIImage *animatingImage;

- (void)showInViewController:(UIViewController *)vc;
- (void)dismiss;
@end
