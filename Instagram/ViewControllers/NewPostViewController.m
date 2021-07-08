//
//  NewPostViewController.m
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/8/21.
//

#import "NewPostViewController.h"
#import "Post.h"
#import <Parse/Parse.h>

@interface NewPostViewController ()
@property (weak, nonatomic) IBOutlet UITextView *captionField;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UIButton *postButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation NewPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.postButton.layer.cornerRadius = 10;
    [self.captionField becomeFirstResponder];
    self.photoView.image = self.image;
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = false;
}

- (IBAction)onPost:(id)sender {
    UIImage *newImage = [self resizeImage:self.image withSize:CGSizeMake(500, 500)];
    [self.activityIndicator startAnimating];
    [Post postUserImage:newImage withCaption:self.captionField.text withCompletion:^(BOOL succeeded, NSError *error) {
        if (succeeded){
            NSLog(@"successfully posted picture");
            [self.activityIndicator stopAnimating];
            [self performSegueWithIdentifier:@"composeSegue" sender:nil];
            self.tabBarController.selectedIndex = 0;
        } else {
            NSLog(@"error: %@", error);
        }
    }];
}

- (IBAction)didEndEditing:(id)sender {
    [self.captionField endEditing:true];
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
