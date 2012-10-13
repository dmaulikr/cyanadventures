//
//  statsandinventory.m
//  Cyan Adventures
//
//  Created by Michael Brand on 07/10/2012.
//
//
#import "statsandinventory.h"
#import "cocos2d.h"

@implementation statsandinventory


- (id)init {
    
    
    if ((self = [super init])) {
        
        inventory = [CCSprite spriteWithFile:@"inventorybutton.png"];
        [inventory setPosition:ccp(40,40)];
        float w4 = [inventory contentSize].width;
        float h4 = [inventory contentSize].height;
        CGPoint dPoint = CGPointMake([inventory position].x - (w4/2), [inventory position].y - (h4/2));
        spBag = CGRectMake(dPoint.x, dPoint.y, w4, h4);
        [self addChild: inventory];
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
            
            test = [CCSprite spriteWithFile:@"snow.png"];
            [test setPosition:ccp(150,150)];
            [self addChild: test];
            
            NSLog(@"Inventory Opened");
            invopen = 1;
        } else if(invopen == 1) {
            
            [self removeChild: test cleanup:YES];
            
            NSLog(@"Inventory Closed");
            invopen = 0;
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
