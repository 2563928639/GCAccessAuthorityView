//
//  ViewController.m
//  GCAccessAuthorityView
//
//  Created by sunflower on 2018/11/8.
//  Copyright © 2018年 sunflower. All rights reserved.
//

#import "ViewController.h"
#import "GCAccessAuthorityView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    GCAccessAuthorityView *accessAuthrityView = [[GCAccessAuthorityView alloc] initWithAccessAuthorityWithType:GCAccessAuthorityTypeContacts];
    [accessAuthrityView gc_checkAccessAuthorityWithCompletionHandler:^(BOOL isEnable) {
        if(!isEnable){
            //            [[UIApplication sharedApplication].keyWindow addSubview:accessAuthrityView];
            [self.view addSubview:accessAuthrityView];
        }
    }];
    
    
    accessAuthrityView.gc_GCAccessAuthorityViewCloseClick = ^{
        
    };

}


@end
