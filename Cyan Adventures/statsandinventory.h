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
    NSString *statstring;
    CCLabelTTF *statlabel;
}

@property (readwrite) int invopen;
@property (readwrite) int statsopen;

@end
