//
//  StoryGameFirstPanel.m
//  Cyan Adventures
//
//  Created by Michael Brand on 05/10/2012.
//
//

#import "StoryGameFirstPanel.h"
#import "BattleScene.h"
#import "CCTouchDispatcher.h"
#import "statsandinventory.h"
#import "StoryGameSecondPanel.h"

#pragma mark - StoryGameFirstPanel

@implementation StoryGameFirstPanel

+(CCScene *) scene
{
    	
    // 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    
    statsandinventory *inv = [statsandinventory node];
    [scene addChild:inv z:3];
    
	// 'layer' is an autorelease object.
	StoryGameFirstPanel *layer = [[[StoryGameFirstPanel alloc] initWithHUD:inv] autorelease];
	
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
		background = [CCSprite spriteWithFile:@"nicepicture.png"];
		background.rotation = 90;
	} else {
		background = [CCSprite spriteWithFile:@"nicepicture-hd.png"];
	}
	background.position = ccp(size.width/2, size.height/2);
    
	// add the label as a child to this Layer
	[self addChild: background];
    [self reorderChild: background z:1];
}



-(id) initWithHUD:(statsandinventory *) inv
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
        _inv = inv;
        
        [self setIsTouchEnabled:TRUE];
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        
        _enemy = [CCSprite spriteWithFile:@"stickfigureenemy.png"];
        [_enemy setPosition:ccp(160,70)];
        [self addChild:_enemy];
        float w2 = [_enemy contentSize].width;
        float h2 = [_enemy contentSize].height;
        CGPoint bPoint = CGPointMake([_enemy position].x - (w2/2), [_enemy position].y - (h2/2));
        spRect = CGRectMake(bPoint.x, bPoint.y, w2, h2);
        [self reorderChild:_enemy z:2];
        
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
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1 scene:[StoryGameSecondPanel scene]]];    }
    if (CGRectContainsPoint(spRectL2, location)) {
        
    }
}

- (void)ccTouchesEnded:(UITouch *)touches withEvent:(UIEvent *)event;
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    if (CGRectContainsPoint(spRect, location)) {
        [[CCDirector sharedDirector] replaceScene: [BattleScene scene]];    }
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
