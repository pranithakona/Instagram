//
//  OpeningViewController.m
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/7/21.
//

#import "OpeningViewController.h"

@interface OpeningViewController ()
@property (weak, nonatomic) IBOutlet UIButton *createButton;

@end

@implementation OpeningViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.createButton.layer.cornerRadius = 5;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
