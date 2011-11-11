//
//  EG_TDAppDelegate.m
//  EG-TD
//
//  Created by metin okur on 16.09.2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//  hhh

#import "EG_TDAppDelegate.h"

#import "EAGLView.h"

#import "EG_TDViewController.h"

@implementation EG_TDAppDelegate


@synthesize window=_window;
@synthesize menuViewController;

@synthesize facebook;
//@synthesize mClient;
@synthesize viewController;
/////
-(void)fakeTimer{
/*    INFSmartFoxRoom *room = [mClient getActiveRoom];
	
	if (room == nil) {
		NSLog(@"BOOOOOS BU ODAAAA");
	}
   // [mClient setActiveRoomId:<#(NSInteger)#>]
    
   // [[[UIApplication sharedApplication] delegate] sendPublicMessage:@"ALIII"];
    [mClient sendPublicMessage:@"Ben geldim" roomId:9];
 NSLog(@"ACTIVE ODANIN ISMI %@",[[[[[mClient getActiveRoom] getUserList] allValues] objectAtIndex:0] getName] )   ;
  */
    [self login:@"HOST"];
}

- (void)onPublicMessage:(INFSmartFoxSFSEvent *)evt
{
   // NSLog(@"LAAAAAAN %@",[[evt.params objectForKey:@"sender"] getName]);
   //NSLog(@"HOOOOOOOP %@",[evt.params objectForKey:@"message"]);
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    ConnectedSFS = false;

    self.window.rootViewController = self.viewController;
    /////
   	//[NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(fakeTimer) userInfo:nil repeats:YES];
    self.viewController = [[EG_TDViewController alloc] initWithNibName:@"EG_TDViewController" bundle:nil];
    [self.window.rootViewController presentModalViewController:self.viewController animated:YES];

   // [self.window.rootViewController presentModalViewController:self.viewController animated:YES];
    //Smartfox init.
  //  [self ConnectToSFS:@"5"];

    return YES;
}
- (void)onUserEnterRoom:(INFSmartFoxSFSEvent *)evt
{
   // NSLog(@"BIRISI GIRDI");
}
-(void) ConnectToFB
{

   
    facebook = [[Facebook alloc] initWithAppId:@"144988148933060" andDelegate:self];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] 
        && [defaults objectForKey:@"FBExpirationDateKey"]) {
        
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    NSArray* permissions =  [[NSArray arrayWithObjects:
                              @"email", @"user_about_me", nil] retain];
    
    if (![facebook isSessionValid]) {
        
        [facebook authorize:permissions];
        
        
        
    }
 
    
    else
    {
        [self.window.rootViewController presentModalViewController:self.viewController animated:YES];
    }
    
    
}

- (void)fbDidLogin {
   
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    
    [self.window.rootViewController presentModalViewController:self.viewController animated:YES];

}

-(void) onObjectReceived:(INFSmartFoxSFSEvent *)evt
{
    
    NSLog(@"Object received");
    
    
    
    
}


-(void) onJoinRoom:(INFSmartFoxSFSEvent *)evt
{
    
    //[self->_viewController RoomVariableAction:[self->mRoom getVariables]];
    
    
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
   // [self.viewController stopAnimation];
}

-(void) onLogin:(INFSmartFoxSFSEvent *)evt
{
      
    if ([[evt.params objectForKey:@"success"] boolValue])
    {
       // NSLog(@"AAAA");
    }
    else
    {
      //  NSLog(@" FAILL to LOG IN");
    }
    
    
}




-(void)login:(NSString *)loginName {
    
    NSLog(@"TTTT");
	[mClient login:@"egtd" name:loginName pass:@""];
	
	INFSmartFoxRoom *room;
	for (id roomId in [mClient getAllRooms]) {
		room = [[mClient getAllRooms] objectForKey:roomId];
		NSLog(@"Room name is: %@",[room getName]);
	}
    
}



-(void) ConnectToSFS:(NSString*) UserId
{
    
    self->mUserID = [[NSString stringWithFormat:@"u%s", [UserId UTF8String]] retain]; 

    if(ConnectedSFS == false)
    {
      
        [INFSmartFoxObjectSerializer setDebug:YES];
        
        mClient = [[INFSmartFoxiPhoneClient iPhoneClient:YES delegate:self] retain];
        
        [mClient loadConfig:@"config" autoConnect:YES]; 
    }
    

    
       
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
    //[self.viewController startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    //[self.viewController stopAnimation];
}

- (void)dealloc
{
    [_window release];
    //[_viewController release];
    [super dealloc];
}

- (void)onConnection:(INFSmartFoxSFSEvent *)evt {
    

	//Enable the login button and the textfield
	if ([[evt.params objectForKey:@"success"] boolValue]) {
		//view.connectLabel.text = @"Connected, please login";
		//view.loginButton.enabled = YES;
		//view.loginTextField.enabled = YES;
          NSLog(@" CONNECTION SUCCESS");
             [self login:@"GURCAN"];
	}
	else {				

        [mClient loadConfig:@"config" autoConnect:YES];
      //  [mClient login:@"simpleChat" name:loginName pass:@""];
		//view.connectLabel.text = [NSString stringWithFormat:@"Connection error: %@", [evt.params objectForKey:@"error"]];
	}
}

- (void)onConnectionLost:(INFSmartFoxSFSEvent *)evt
{
	NSLog(@"onConnectionLost");
	
    //Disable textfield and button until connected!
	//view.loginTextField.enabled = NO;
	//view.loginButton.enabled = NO;	
	  ConnectedSFS = false;
    //Retry connection
	[mClient loadConfig:@"config" autoConnect:YES];
}



@end