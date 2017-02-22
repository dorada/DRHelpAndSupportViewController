//
//  DRAppDelegate.m
//  DRHelpAndSupportViewController
//
//  Created by Daniel Broad on 02/06/2016.
//  Copyright (c) 2016 Daniel Broad. All rights reserved.
//

#import "DRHelpAppDelegate.h"

#import "DRLogger.h"

#import "DRHelpAndSupportViewController.h"

#import "DRTwitterLinkHelpItem.h"
#import "DRHelpAndSupportItem.h"
#import "DRGetHelpItem.h"

@implementation DRHelpAppDelegate {
    DRLogger *_importantLogFile;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _importantLogFile = [[DRLogger alloc] initWithIdentifier:@"Important" isPersistent:YES];
    self.window = [[UIWindow alloc] init];
    // Override point for customization after application launch.
    DRHelpAndSupportViewController *help = [[DRHelpAndSupportViewController alloc] initWithCancelButton:NO];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:help];

    help.supportSections = [self supportSections];
    
    UIViewController *blank = [[UIViewController alloc] init];
    blank.title = @"blank"; blank.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *blankNav = [[UINavigationController alloc] initWithRootViewController:blank];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = [NSArray arrayWithObjects:blankNav,nav, nil];
    nav.tabBarItem.image = help.helpTabBarImage;
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - support sections

-(NSArray*) supportSections {
    
    DRHelpAndSupportSection *section1 = [[DRHelpAndSupportSection alloc] initWithTitle:NSLocalizedString(@"Help", nil)
                                                                             helpItems:@[
                                                                                         [DRHelpViewController quickHelpItem],
                                                                                         [[DRHelpAndSupportItem alloc] initWithTitle:NSLocalizedString(@"FAQ", nil) actionHandler:^(DRHelpAndSupportItem *item) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://support.dorada.co.uk"]];
    }],
                                                                                         [[DRGetHelpItem alloc] initWithTitle:NSLocalizedString(@"Get Help", nil)
                                                                                                              recipientEmails:@[@"support@dorada.co.uk"] attachmentPaths:@[_importantLogFile.persistantFilePath]
                                                                                          ],
                                                                                         ]
                                         ];
    DRHelpAndSupportSection *section2 = [[DRHelpAndSupportSection alloc] initWithTitle:NSLocalizedString(@"Links", nil)
                                                                             helpItems:@[
                                                                                         [[DRTwitterLinkHelpItem alloc] initWithTwitterUsername:@"DoradaSoftware"],
                                                                                         ]];
    
    return @[section1,section2];
}
@end
