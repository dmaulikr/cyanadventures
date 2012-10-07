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
    int might;
    int cunning;
    int wisdom;
    float critchance;
    int armour;
    int gold;
}

+(CCScene *) scene;
@end
