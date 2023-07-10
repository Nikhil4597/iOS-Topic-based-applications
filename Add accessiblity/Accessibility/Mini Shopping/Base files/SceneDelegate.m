//
//  SceneDelegate.m
//  Mini Shopping
//
//  Created by ROHIT MISHRA on 15/04/23.
//

#import "SceneDelegate.h"
#import "MainViewController.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    self.window =  [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.windowScene = (UIWindowScene *)scene;

    // Initilize main view controller.
    UIViewController * mainVC = [[MainViewController alloc] init];

    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController: mainVC];
    [self.window makeKeyAndVisible];
}

@end
