//
//  StoryGameSecondPanel.m
//  Cyan Adventures
//
//  Created by Michael Brand on 19/10/2012.
//
//

#import "StoryGameSecondPanel.h"
#import "BattleScene.h"
#import "CCTouchDispatcher.h"
#import "statsandinventory.h"
#import "StoryGameFirstPanel.h"

#pragma mark - StoryGameSecondPanel

@implementation StoryGameSecondPanel

+(CCScene *) scene
{
    
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    statsandinventory *inv = [statsandinventory node];
    [scene addChild:inv z:3];
    
	// 'layer' is an autorelease object.
	StoryGameSecondPanel *layer = [[[StoryGameSecondPanel alloc] initWithHUD:inv] autorelease];
	
	// add layer as a child to scene
	[scene addChild: layer];
    
    
    
	// return the scene
	return scene;
}

-(void) onEnter
{
	[super onEnter];
    
	// ask director for the window size
	CGSize size = [[CCDirector sharedDirector] winSize];
    
	CCSprite *background;
	
	if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
		background = [CCSprite spriteWithFile:@"nicepicture2.png"];
		background.rotation = 90;
	} else {
		background = [CCSprite spriteWithFile:@"nicepicture2-hd.png"];
	}
	background.position = ccp(size.width/2, size.height/2);
    
	// add the label as a child to this Layer
	[self addChild: background];
    
}



-(id) initWithHUD:(statsandinventory *) inv
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        _inv = inv;
        
        [self setIsTouchEnabled:TRUE];
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        //Setting Up Arrow Buttons
        CCSprite *rightarrow2 = [CCSprite spriteWithFile:@"arrow-right.png"];
        [rightarrow2 setPosition:ccp(size.width - 20,size.height/2)];
        [self addChild:rightarrow2];
        float w = [rightarrow2 contentSize].width;
        float h = [rightarrow2 contentSize].height;
        CGPoint aPoint = CGPointMake([rightarrow2 position].x - (w/2), [rightarrow2 position].y - (h/2));
        spRectR2 = CGRectMake(aPoint.x, aPoint.y, w, h);
        [self reorderChild:rightarrow2 z:2];
        
        CCSprite *leftarrow2 = [CCSprite spriteWithFile:@"arrow-left.png"];
        [leftarrow2 setPosition:ccp(20,size.height/2)];
        [self addChild:leftarrow2];
        float w3 = [leftarrow2 contentSize].width;
        float h3 = [leftarrow2 contentSize].height;
        CGPoint cPoint = CGPointMake([leftarrow2 position].x - (w3/2), [leftarrow2 position].y - (h3/2));
        spRectL2 = CGRectMake(cPoint.x, cPoint.y, w3, h3);
        [self reorderChild:leftarrow2 z:2];
	}
	return self;
}

- (void)ccTouchesBegan:(UITouch *)touches withEvent:(UIEvent *)event;
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    if (CGRectContainsPoint(spRectR2, location)) {

    }
    if (CGRectContainsPoint(spRectL2, location)) {
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[StoryGameFirstPanel scene]]];    }
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

