//
//  SignUpViewController.m
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/6/21.
//

#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)dismissKeyboard:(id)sender {
    [self.usernameField endEditing:true];
    [self.passwordField endEditing:true];
    [self.emailField endEditing:true];
}

- (IBAction)onSignup:(id)sender {
    PFUser *newUser = [PFUser user];
       
       // set user properties
       newUser.username = self.usernameField.text;
       newUser.email = self.emailField.text;
       newUser.password = self.passwordField.text;
       
       // call sign up function on the object
       [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
           if (error != nil) {
               NSLog(@"Error: %@", error.localizedDescription);
           } else {
               NSLog(@"User registered successfully");
               
               [self performSegueWithIdentifier:@"signupSegue" sender:nil];
           }
       }];
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
