//
//  statsandinventory.m
//  Cyan Adventures
//
//  Created by Michael Brand on 07/10/2012.
//
//
#import "statsandinventory.h"
#import "cocos2d.h"
#import "CCLayer.h"

@implementation statsandinventory


- (id)init {
    
    
    if ((self = [super init])) {
        
        strength = 10;
        dexterity = 10;
        intelligence = 10;
        
        inventory = [CCSprite spriteWithFile:@"inventorybutton.png"];
        [inventory setPosition:ccp(40,40)];
        float w4 = [inventory contentSize].width;
        float h4 = [inventory contentSize].height;
        CGPoint dPoint = CGPointMake([inventory position].x - (w4/2), [inventory position].y - (h4/2));
        spBag = CGRectMake(dPoint.x, dPoint.y, w4, h4);
        [self addChild: inventory];
        [self setIsTouchEnabled:TRUE];
        
        
        statsbutton = [CCSprite spriteWithFile:@"mysecondbutton.png"];
        [statsbutton setPosition:ccp(300,40)];
        float w5 = [statsbutton contentSize].width;
        float h5 = [statsbutton contentSize].height;
        CGPoint ePoint = CGPointMake([statsbutton position].x - (w5/2), [statsbutton position].y - (h5/2));
        spStats = CGRectMake(ePoint.x, ePoint.y, w5, h5);
        [self addChild: statsbutton];
        [self setIsTouchEnabled:TRUE];
    }
    return self;
}

- (void)ccTouchesBegan:(UITouch *)touches withEvent:(UIEvent *)event;
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    if (CGRectContainsPoint(spBag, location)) {
        if(invopen == 0) {
            if(statsopen == 0) {
                lcinv = [CCLayerColor layerWithColor:ccc4(205, 198, 115, 200) width:(300) height:(300)];
                lcinv.position = ccp(75,75);
                [self addChild: lcinv];
            
                NSLog(@"Inventory Opened");
                invopen = 1;
            }
        } else if(invopen == 1) {
            
            [self removeChild: lcinv cleanup:YES];
            
            NSLog(@"Inventory Closed");
            invopen = 0;
        }
    }
    
    if (CGRectContainsPoint(spStats, location)) {
        if(statsopen == 0) {
            if(invopen == 0) {
                lcstats = [CCLayerColor layerWithColor:ccc4(255, 255, 255, 255) width:(100) height:(100)];
                lcstats.position = ccp(380,25);
                [self addChild: lcstats];
            
                statstring1 = [NSString stringWithFormat:@"Strength: %d", strength];
                statlabel1 = [CCLabelTTF labelWithString:statstring1 fontName:@"Marker Felt" fontSize:15];
                [statlabel1 setPosition:ccp(50,80)];
                [lcstats addChild: statlabel1];
                statlabel1.color = ccc3(255,0,0);
            
                statstring2 = [NSString stringWithFormat:@"Dexterity: %d", dexterity];
                statlabel2 = [CCLabelTTF labelWithString:statstring2 fontName:@"Marker Felt" fontSize:15];
                [statlabel2 setPosition:ccp(50,60)];
                [lcstats addChild: statlabel2];
                statlabel2.color = ccc3(0,255,0);
            
                statstring3 = [NSString stringWithFormat:@"Intelligence: %d", intelligence];
                statlabel3 = [CCLabelTTF labelWithString:statstring3 fontName:@"Marker Felt" fontSize:15];
                [statlabel3 setPosition:ccp(50,40)];
                [lcstats addChild: statlabel3];
                statlabel3.color = ccc3(0,0,255);
            
                NSLog(@"Stat screen Opened");
                statsopen = 1;
            }
        } else if(statsopen == 1) {
            
            [self removeChild: lcstats cleanup:YES];
            
            NSLog(@"Stat screen Closed");
            statsopen = 0;
        }
    }
}

- (void)ccTouchesEnded:(UITouch *)touches withEvent:(UIEvent *)event;
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    
    location = [[CCDirector sharedDirector] convertToGL:location];

}


- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
