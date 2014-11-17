//
//  NBDetailListContainerViewController.m
//  NotInboxByGmail
//
//  Created by Nia Mutiara on 13/11/14.
//  Copyright (c) 2014 CatCyborg. All rights reserved.
//

#import "NBDetailListContainerViewController.h"

@interface NBDetailListContainerViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *containerViewBottomConstraint;

@property (weak, nonatomic) UIImageView *navigationBarImageView;
@property (weak, nonatomic) UIImageView *topCurtainImageView;
@property (weak, nonatomic) UIImageView *bottomCurtainImageView;

@property (weak, nonatomic) NSLayoutConstraint *navigationBarImageViewTopConstraint;
@property (weak, nonatomic) NSLayoutConstraint *topCurtainImageViewTopConstraint;
@property (weak, nonatomic) NSLayoutConstraint *bottomCurtainImageViewBottomConstraint;

@end

@implementation NBDetailListContainerViewController

- (void)showInViewController:(UIViewController *)vc
{
    [self willMoveToParentViewController:vc];
    [vc addChildViewController:self];
    [vc.view addSubview:self.view];
    [self didMoveToParentViewController:vc];

    [vc.view addConstraints:@[
                             [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:vc.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0],
                             [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:vc.view attribute:NSLayoutAttributeTop multiplier:1 constant:0],
                             [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:vc.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0],
                             [NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:vc.view attribute:NSLayoutAttributeRight multiplier:1 constant:0],
                             ]];

    [self prepareCurtainsOnViewController:self];
    [self animateIn];
}

- (void)dismiss
{
    [self animateOut];
}

- (void)prepareCurtainsOnViewController:(UIViewController *)vc
{
    UIImage *img = self.animatingImage;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat w = img.size.width, h = 64, H = img.size.height;
    CGRect slice1 = (CGRect){0, 0, w*scale, h*scale};
    CGRect slice2 = (CGRect){
        0, h*scale,
        w*scale, (_originRect.origin.y+_originRect.size.height-h)*scale
    };
    CGRect slice3 = (CGRect){
        0, (_originRect.origin.y+_originRect.size.height)*scale, w*scale,
        (H-(_originRect.origin.y+_originRect.size.height))*scale
    };

    CGImageRef imageRef = CGImageCreateWithImageInRect([img CGImage], slice1);
    UIImageView *navigationBarImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:imageRef]];
    navigationBarImageView.frame = slice1;
    navigationBarImageView.translatesAutoresizingMaskIntoConstraints = NO;
    navigationBarImageView.contentMode = UIViewContentModeScaleAspectFit;
    [navigationBarImageView sizeToFit];
    [vc.view insertSubview:navigationBarImageView belowSubview:self.containerView];
    NSLayoutConstraint *navigationBarImageViewTopConstraint = [NSLayoutConstraint constraintWithItem:navigationBarImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:vc.view attribute:NSLayoutAttributeTop multiplier:1 constant:slice1.origin.y/scale];
    [vc.view addConstraints:@[
                              navigationBarImageViewTopConstraint,
                              [NSLayoutConstraint constraintWithItem:navigationBarImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:vc.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0],
                              [NSLayoutConstraint constraintWithItem:navigationBarImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:vc.view attribute:NSLayoutAttributeRight multiplier:1 constant:0],
                              [NSLayoutConstraint constraintWithItem:navigationBarImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:slice1.size.height/scale],
                              ]];
    self.navigationBarImageView = navigationBarImageView;
    self.navigationBarImageViewTopConstraint = navigationBarImageViewTopConstraint;

    imageRef = CGImageCreateWithImageInRect([img CGImage], slice2);
    UIImageView *topCurtainImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:imageRef]];
    topCurtainImageView.translatesAutoresizingMaskIntoConstraints = NO;
    topCurtainImageView.frame = slice2;
    topCurtainImageView.contentMode = UIViewContentModeScaleAspectFit;
    [vc.view insertSubview:topCurtainImageView belowSubview:self.containerView];
    NSLayoutConstraint *topCurtainImageViewTopConstraint = [NSLayoutConstraint constraintWithItem:topCurtainImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:vc.view attribute:NSLayoutAttributeTop multiplier:1 constant:slice2.origin.y/scale];
    [vc.view addConstraints:@[
                              topCurtainImageViewTopConstraint,
                              [NSLayoutConstraint constraintWithItem:topCurtainImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:vc.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0],
                              [NSLayoutConstraint constraintWithItem:topCurtainImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:vc.view attribute:NSLayoutAttributeRight multiplier:1 constant:0],
                              [NSLayoutConstraint constraintWithItem:topCurtainImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:slice2.size.height/scale],
                              ]];
    self.topCurtainImageView = topCurtainImageView;
    self.topCurtainImageViewTopConstraint = topCurtainImageViewTopConstraint;

    imageRef = CGImageCreateWithImageInRect([img CGImage], slice3);
    UIImageView *bottomCurtainImageView = [[UIImageView alloc] initWithImage:[UIImage imageWithCGImage:imageRef]];
    bottomCurtainImageView.translatesAutoresizingMaskIntoConstraints = NO;
    bottomCurtainImageView.contentMode = UIViewContentModeScaleAspectFit;
    [vc.view insertSubview:bottomCurtainImageView belowSubview:self.containerView];
    NSLayoutConstraint *bottomCurtainImageViewBottomConstraint = [NSLayoutConstraint constraintWithItem:bottomCurtainImageView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:vc.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    [vc.view addConstraints:@[
                              bottomCurtainImageViewBottomConstraint,
                              [NSLayoutConstraint constraintWithItem:bottomCurtainImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:vc.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0],
                              [NSLayoutConstraint constraintWithItem:bottomCurtainImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:vc.view attribute:NSLayoutAttributeRight multiplier:1 constant:0],
                              [NSLayoutConstraint constraintWithItem:bottomCurtainImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:slice3.size.height/scale],
                              ]];
    self.bottomCurtainImageView = bottomCurtainImageView;
    self.bottomCurtainImageViewBottomConstraint = bottomCurtainImageViewBottomConstraint;
}

- (void)animateIn
{
    self.containerViewTopConstraint.constant = self.originRect.origin.y;
    self.containerViewBottomConstraint.constant = self.animatingImage.size.height - CGRectGetMaxY(self.originRect);
    [self.view layoutIfNeeded];
    typeof(self) weakSelf = self;

    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.navigationBarImageViewTopConstraint.constant = -64;
        weakSelf.topCurtainImageViewTopConstraint.constant = -weakSelf.topCurtainImageView.frame.size.height;
        weakSelf.bottomCurtainImageViewBottomConstraint.constant = weakSelf.view.frame.size.height;

        weakSelf.containerViewTopConstraint.constant = 0;
        weakSelf.containerViewBottomConstraint.constant = 0;
        [weakSelf.view layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
}

- (void)animateOut
{
    self.containerViewTopConstraint.constant = 0;
    self.containerViewBottomConstraint.constant = 0;
    [self.containerView layoutIfNeeded];
    typeof(self) weakSelf = self;

    [UIView animateWithDuration:0.3 animations:^{
        weakSelf.navigationBarImageViewTopConstraint.constant = 0;
        weakSelf.topCurtainImageViewTopConstraint.constant = 64;
        weakSelf.bottomCurtainImageViewBottomConstraint.constant = 0;

        weakSelf.containerViewTopConstraint.constant = weakSelf.originRect.origin.y;
        weakSelf.containerViewBottomConstraint.constant = weakSelf.animatingImage.size.height - CGRectGetMaxY(weakSelf.originRect);
        [weakSelf.view layoutIfNeeded];
        weakSelf.containerView.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf willMoveToParentViewController:nil];
        [weakSelf.view removeFromSuperview];
        [weakSelf removeFromParentViewController];
        [weakSelf didMoveToParentViewController:nil];
    }];
}

@end
