//
//  LKAccountPanelAppDelegate.m
//  LKAccountPanel
//
//  Created by Hiroshi Hashiguchi on 11/05/08.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LKAccountPanelAppDelegate.h"
#import "LKAccountPanel.h"

@implementation LKAccountPanelAppDelegate


@synthesize window=_window;
@synthesize usernameTextFiled, passwordTextFiled;
@synthesize passwordSwitch;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    self.usernameTextFiled = nil;
    self.passwordTextFiled = nil;
    [super dealloc];
}

- (NSString*)_getUsername
{
    if (self.usernameTextFiled.text && [self.usernameTextFiled.text length]>0) {
        return [[self.usernameTextFiled.text copy] autorelease];
    }
    return nil;
}
- (NSString*)_getPassword
{
    if (self.passwordTextFiled.text && [self.passwordTextFiled.text length]>0) {
        return [[self.passwordTextFiled.text copy] autorelease];
    }
    return nil;
}

- (IBAction)showAsyncInMain:(id)sender
{
    [LKAccountPanel showWithTitle:@"Test"
                         username:[self _getUsername]
                         password:[self _getPassword]
                       completion:^(BOOL result, NSString* username, NSString* password) {
                           NSLog(@"    result: %d\nusername: %@\npassword: %@",
                                 result, username, password);
                       }];
    NSLog(@"done: Async in main thread");
}

- (IBAction)showSyncInMain:(id)sender
{
    NSString* username = [self _getUsername];
    NSString* password = [self _getPassword];
    
    BOOL result = [LKAccountPanel showWithTitle:@"Test2"
                                       username:&username
                                       password:&password];
    NSLog(@"done: Sync in main thread");
    NSLog(@"    result: %d\nusername: %@\npassword: %@",
          result, username, password);
}

- (IBAction)showAsyncInOther:(id)sender
{
    NSString* username = [self _getUsername];
    NSString* password = [self _getPassword];

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [LKAccountPanel showWithTitle:@"Test"
                             username:username
                             password:password
                           completion:^(BOOL result, NSString* username, NSString* password) {
                               NSLog(@"    result: %d\nusername: %@\npassword: %@",
                                     result, username, password);
                           }];
        NSLog(@"done: Async in other thread");        
    });
}

- (IBAction)showSyncInOther:(id)sender
{
    NSString* username = [self _getUsername];
    NSString* password = [self _getPassword];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString* u = [[username copy] autorelease];
        NSString* p = [[password copy] autorelease];
        BOOL result = [LKAccountPanel showWithTitle:@"Test2"
                                           username:&u
                                           password:&p];
        NSLog(@"done: Sync in other thread");
        NSLog(@"    result2: %d\nusername: %@\npassword: %@",
              result, username, password);
    });
}

- (IBAction)changePasswordSwitch:(id)sender {
    [LKAccountPanel setPasswordOnly:self.passwordSwitch.on];
}


@end
