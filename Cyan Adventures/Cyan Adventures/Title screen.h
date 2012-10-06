//
//  Title screen.h
//  Tell Me A Story
//
//  Created by Michael Brand on 04/10/2012.
//
//

#import "CCScene.h"
#import "cocos2d.h"

@interface Title_screen : CCLayer
{
    CCSprite * background;
    NSInteger backgroundanimationswitcher;
    CCSprite * cloud;
    CGRect menuChoice1;
}

+(id) scene;

@end