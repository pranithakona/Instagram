//
//  NewPostViewController.m
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/8/21.
//

#import "NewPostViewController.h"
#import "FeedViewController.h"
#import "Post.h"
#import <Parse/Parse.h>
#import "SceneDelegate.h"

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

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = false;
}

- (IBAction)onPost:(id)sender {
    UIImage *newImage = [self resizeImage:self.image withSize:CGSizeMake(500, 500)];
    [self.activityIndicator startAnimating];
    [Post postUserImage:newImage withCaption:self.captionField.text withUser:self.user withCompletion:^(BOOL succeeded, NSError *error) { 
        if (succeeded){
            NSLog(@"successfully posted picture");
            [self.activityIndicator stopAnimating];

            SceneDelegate *sceneDelegate = (SceneDelegate *)[UIApplication sharedApplication].connectedScenes.allObjects[0].delegate;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UITabBarController *tabBarController = [storyboard instantiateViewControllerWithIdentifier:@"FeedTabBarController"];
            sceneDelegate.window.rootViewController = tabBarController;
        } else {
            NSLog(@"error: %@", error);
        }
    }];
}

- (IBAction)didEndEditing:(id)sender {
    [self.captionField endEditing:true];
}

@end
