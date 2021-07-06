//
//  DetailsViewController.m
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/6/21.
//

#import "DetailsViewController.h"
#import <Parse/PFImageView.h>

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet PFImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *createdAtLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.photoView.file = self.post[@"image"];
    [self.photoView loadInBackground];
    self.authorLabel.text = self.post.author.username;
    self.captionLabel.text = self.post.caption;
    self.createdAtLabel.text = [NSString stringWithFormat: @"%@", self.post.createdAt];
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
