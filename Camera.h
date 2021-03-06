//
//  Camera.h
//  EG-TD
//
//  Created by Gurcan Yavuz on 10/8/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AbstractEntity.h"


@class GameScene;
@class RaceBall;

@interface Camera : AbstractEntity {
    
    Director *_sharedDirector;
    float collideCube;
    float readyCheck;
    float cameraZ;
    
    float lookUpX;
    float lookUpY;
    float lookUpZ;
    
    float xDifference;
    float yDifference;
    
    float _cameraSpeed;
    GameScene *_scene;
    
    float oldPosition;
    
    RaceBall *raceBall;
    
    
}
@property (nonatomic, readonly)RaceBall *raceBall;
@property (nonatomic, assign)float oldPosition;
@property (nonatomic, assign) float collideCube;
@property (nonatomic, assign) float readyCheck;
@property (nonatomic, assign) float cameraZ;
@property (nonatomic, assign)float lookUpX;
@property (nonatomic, assign)float lookUpY;
@property (nonatomic, assign)float lookUpZ;
@property (nonatomic, readonly) float xDifference;
@property (nonatomic, readonly) float yDifference;
- (id)initWithTileLocation:(EGVertex3D)startLocation;
- (void)updateX:(NSString *)xPos updateY:(NSString *)yPos updateZ:(NSString *)zPos;


@end
