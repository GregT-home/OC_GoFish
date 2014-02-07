//
//  customViewController.m
//  Spike_CollectionView
//
//  Created by Greg Tarsa on 2/3/14.
//  Copyright (c) 2014 Greg Tarsa. All rights reserved.
//

#import "SmileyFaceVC.h"
#import "SmileyFaceView.h"


@interface SmileyFaceVC ()

@end

@implementation SmileyFaceVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view = [SmileyFaceView new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
