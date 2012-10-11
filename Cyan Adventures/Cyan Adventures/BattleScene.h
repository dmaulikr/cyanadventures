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
    //Movement Controls
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
    CCSprite * _player;
    CCSprite * bluebutton;
    CCSprite * redbutton;
    NSInteger Playermoving;
    NSInteger ButtonPressed;
    NSInteger ButtonPressLife;
    NSInteger Flame;
    CCSprite * flame;
    NSInteger Spellcountdown;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end