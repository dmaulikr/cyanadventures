//
//  statsandinventory.h
//  Cyan Adventures
//
//  Created by Michael Brand on 07/10/2012.
//
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface statsandinventory : CCLayer
{
    int hitpoints;
    int mana;
    int strength;
    int dexterity;
    int intelligence;
    float critchance;
    int armour;
    int gold;
    int invopen;
    int statsopen;
    CCArray *inventoryarray;
    CGRect spBag;
    CGRect spStats;
    CCSprite *inventory;
    CCSprite *statsbutton;
    CCSprite *test;
    NSString *statstring1;
    NSString *statstring2;
    NSString *statstring3;
    CCLabelTTF *statlabel1;
    CCLabelTTF *statlabel2;
    CCLabelTTF *statlabel3;
    CCLayerColor *lcstats;
    CCLayerColor *lcinv;
}

@property (readwrite) int invopen;
@property (readwrite) int statsopen;
@property (readwrite) int strength;

@end
