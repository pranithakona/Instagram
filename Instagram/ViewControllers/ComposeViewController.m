//
//  ComposeViewController.m
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/6/21.
//

#import "ComposeViewController.h"
#import "NewPostViewController.h"
#import "Post.h"

@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@property (strong, nonatomic) User *user;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self fetchUser];
    
    self.nextButton.layer.cornerRadius = 10;
    self.addButton.layer.cornerRadius = 10;
    
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:
      [UIAction actionWithTitle:@"Camera" image:nil identifier:nil handler:^(UIAction* action){
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerVC animated:YES completion:nil];
}],
      [UIAction actionWithTitle:@"Photo Library" image:nil identifier:nil handler:^(UIAction* action){
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerVC animated:YES completion:nil];
}],
      nil];
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        [array removeObjectAtIndex:0];
    }
    
    UIMenu *menu = [UIMenu menuWithTitle:@"" children:array];
    self.addButton.menu = menu;
    self.addButton.showsMenuAsPrimaryAction = true;

   
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];

    
    self.photoView.image = originalImage;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    self.nextButton.hidden = false;
}

-(void) fetchUser{
    PFQuery *query = [PFQuery queryWithClassName:@"Account"];
    query.limit = 20;
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    [query includeKey:@"image"];
    [query includeKey:@"bio"];
    [query includeKey:@"name"];
    [query includeKey:@"user"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.user = posts[0];
            NSLog(@"Successfully loaded user");
        } else {
            NSLog(@"error: %@", error.localizedDescription);
        }
    }];
    
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"%@", self.user);
    NewPostViewController *newPostViewController = [segue destinationViewController];
    newPostViewController.image = self.photoView.image;
    newPostViewController.user = self.user;
}


@end
