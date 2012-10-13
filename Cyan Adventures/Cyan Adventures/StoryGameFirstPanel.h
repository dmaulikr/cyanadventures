//
//  StoryGameFirstPanel.h
//  Cyan Adventures
//
//  Created by Michael Brand on 05/10/2012.
//
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "statsandinventory.h"

@interface StoryGameFirstPanel : CCLayer
{
    //Movement Controls
    CGRect spRectR2;
    CGRect spRectL2;
    CGRect spRect;
    CCSprite * _enemy;
    statsandinventory *_inv;
    }

-(id)initWithHUD:(statsandinventory *) inv;
+(CCScene *) scene;
@end
