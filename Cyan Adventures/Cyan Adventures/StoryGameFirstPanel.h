//
//  StoryGameFirstPanel.h
//  Cyan Adventures
//
//  Created by Michael Brand on 05/10/2012.
//
//

#import "CCLayer.h"
#import "cocos2d.h"

@interface StoryGameFirstPanel : CCLayer
{
    //Movement Controls
    CGRect spRectR2;
    CGRect spRectL2;
    CGRect spRect;
    CGRect spBag;
    CCSprite * _enemy;
    int toggle;
    }

+(CCScene *) scene;
@end
