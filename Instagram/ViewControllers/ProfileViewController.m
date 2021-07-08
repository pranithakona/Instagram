//
//  ProfileViewController.m
//  Instagram
//
//  Created by Pranitha Reddy Kona on 7/8/21.
//

#import "ProfileViewController.h"
#import "OpeningViewController.h"
#import "SceneDelegate.h"
#import "ProfileHeaderView.h"
#import "ProfileCell.h"
#import <Parse/Parse.h>

@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//@property (weak, nonatomic) IBOutlet UIButton *optionsButton;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    

}

- (IBAction)doDismiss:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ProfileCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ProfileCell" forIndexPath:indexPath];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    ProfileHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:                             UICollectionElementKindSectionHeader withReuseIdentifier:@"ProfileHeaderView" forIndexPath:indexPath];

    NSArray *array = [NSArray arrayWithObjects:
                      [UIAction actionWithTitle:@"Edit Profile" image:nil identifier:nil handler:^(UIAction* action){}],
                      [UIAction actionWithTitle:@"Log Out" image:nil identifier:nil handler:^(UIAction* action){[self onLogout];}],
                      nil];
    UIMenu *menu = [UIMenu menuWithTitle:@"" children:array];
    headerView.optionsButton.menu = menu;
    headerView.optionsButton.showsMenuAsPrimaryAction = true;
    return headerView;

}

- (void)onLogout {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        SceneDelegate *sceneDelegate = (SceneDelegate *)[UIApplication sharedApplication].connectedScenes.allObjects[0].delegate;
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        OpeningViewController *openingViewController = [storyboard instantiateViewControllerWithIdentifier:@"OpeningViewController"];
        sceneDelegate.window.rootViewController = openingViewController;
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
