//
//  BattleScene.h
//  Cyan Adventures
//
//  Created by Michael Paul on 05/10/2012.
//
//

#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface BattleScene : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    //Controls
    CGRect spRectR;
    CGRect spRectL;
    CGRect spRectU;
    CGRect spRectD;
    CGRect spRectRU;
    CGRect spRectRD;
    CGRect spRectLU;
    CGRect spRectLD;
    CGRect spRectBB;
    CGRect spRectRB;
    CCSprite * bluebutton;
    CCSprite * redbutton;
    
    //PLAYER STATS
    //Sprites
    CCSprite * _player;
    CCSprite * flame;
    CCSprite * blizzardstorm1;
    CCSprite * blizzardstorm2;
    CCSprite * blizzardstorm3;
    CCSprite * blizzardstorm4;
    CCSprite * blizzardstorm5;
    CCSprite * blizzardstorm6;
    
    //Integers
    NSInteger Playermoving;
    NSInteger ButtonPressed;
    NSInteger ButtonPressLife;
    NSInteger Flame;
    NSInteger Blizzardstorm;
    NSInteger Spellcountdown;
    NSInteger Playerducking;
    NSInteger Jumping;
    NSInteger JumpingR;
    NSInteger JumpingL;
    NSInteger SlidingL;
    NSInteger Test;
    NSInteger SlidingR;
    
    //Textures
    CCTexture2D *flameanimation1;
    CCTexture2D *flameanimation2;
    CCTexture2D *stationary;
    CCTexture2D *ducking;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end