//
//  EG_TDAppDelegate.h
//  EG-TD
//  //asdff
//  Created by metin okur on 16.09.2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "INFSmartFoxISFSEvents.h"
#import "INFSmartFoxSFSEvent.h"
#import "INFSmartFoxiPhoneClient.h"
#import "INFSmartFoxObjectSerializer.h"
#import "INFSmartFoxRoom.h"
#import "MenuViewController.h"
#import "FBConnect.h"

//osman
@class EG_TDViewController;
@class MenuViewController;

@interface EG_TDAppDelegate : NSObject <UIApplicationDelegate, INFSmartFoxISFSEvents, FBSessionDelegate> // 
{
    
    INFSmartFoxiPhoneClient* mClient;
    bool ConnectedSFS;
    INFSmartFoxRoom *mRoom;
    NSString* mUserID;
    Facebook* facebook;
    bool GameStarted;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet EG_TDViewController *viewController;
@property (nonatomic, retain) IBOutlet MenuViewController *menuViewController; 

@property (nonatomic, retain) INFSmartFoxiPhoneClient *mClient;
@property (nonatomic, retain) Facebook *facebook;

-(void) ConnectToSFS: (NSString*) UserID;
-(void) ConnectToFB;
-(void)login:(NSString *)loginName;

@end
