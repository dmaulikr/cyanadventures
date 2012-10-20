//
//  StoryGameSecondPanel.h
//  Cyan Adventures
//
//  Created by Michael Brand on 19/10/2012.
//
//

#import "CCLayer.h"
#import "cocos2d.h"
#import "statsandinventory.h"

@interface StoryGameSecondPanel : CCLayer
{
    CGRect spRectR2;
    CGRect spRectL2;
    
    statsandinventory *_inv;
}

-(id)initWithHUD:(statsandinventory *) inv;
+(CCScene *) scene;
@end
