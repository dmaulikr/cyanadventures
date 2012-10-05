//
//  BattleScene.m
//  Cyan Adventures
//
//  Created by Michael Paul on 05/10/2012.
//
//

#import "BattleScene.h"
#import "CCTouchDispatcher.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation BattleScene

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	BattleScene *layer = [BattleScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Battle Test" fontName:@"Marker Felt" fontSize:20];
        
		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
        
		// position the label on the center of the screen
		label.position =  ccp( size.width /2 , size.height - 20 );
		
		// add the label as a child to this Layer
		[self addChild: label];
        
        //Setting Layer to respond to touch
        [self setIsTouchEnabled:TRUE];
        
        //Creating Player Sprite
        _player = [CCSprite spriteWithFile:@"stickfigure.png"];
        [_player setPosition:ccp(160,240)];
        [self addChild:_player];
        //  Playermoving = 0;
        
        
        
        //Setting Up Arrow Buttons
        CCSprite *rightarrow = [CCSprite spriteWithFile:@"arrowright.png"];
        [rightarrow setPosition:ccp(size.width -20,20)];
        [self addChild:rightarrow];
        float w = [rightarrow contentSize].width;
        float h = [rightarrow contentSize].height;
        CGPoint aPoint = CGPointMake([rightarrow position].x - (w/2), [rightarrow position].y - (h/2));
        spRectR = CGRectMake(aPoint.x, aPoint.y, w, h);
        
        CCSprite *uparrow = [CCSprite spriteWithFile:@"arrowup.png"];
        [uparrow setPosition:ccp(size.width -80,20)];
        [self addChild:uparrow];
        float w2 = [uparrow contentSize].width;
        float h2 = [uparrow contentSize].height;
        CGPoint bPoint = CGPointMake([uparrow position].x - (w2/2), [uparrow position].y - (h2/2));
        spRectU = CGRectMake(bPoint.x, bPoint.y, w2, h2);
        
        CCSprite *leftarrow = [CCSprite spriteWithFile:@"arrowleft.png"];
        [leftarrow setPosition:ccp(size.width -140,20)];
        [self addChild:leftarrow];
        float w3 = [leftarrow contentSize].width;
        float h3 = [leftarrow contentSize].height;
        CGPoint cPoint = CGPointMake([leftarrow position].x - (w3/2), [leftarrow position].y - (h3/2));
        spRectL = CGRectMake(cPoint.x, cPoint.y, w3, h3);
        
        CCSprite *downarrow = [CCSprite spriteWithFile:@"arrowdown.png"];
        [downarrow setPosition:ccp(size.width -200,20)];
        [self addChild:downarrow];
        float w4 = [downarrow contentSize].width;
        float h4 = [downarrow contentSize].height;
        CGPoint dPoint = CGPointMake([downarrow position].x - (w4/2), [downarrow position].y - (h4/2));
        spRectD = CGRectMake(dPoint.x, dPoint.y, w4, h4);
        
        //Setting Up Scheduler
        [self schedule:@selector(playerMovement:) interval:0];
        
	}
	return self;
}


- (void)ccTouchesBegan:(UITouch *)touches withEvent:(UIEvent *)event;
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    if (CGRectContainsPoint(spRectR, location)) {
        Playermoving = 4;
    }
    if (CGRectContainsPoint(spRectL, location)) {
        Playermoving = 3;
    }
    if (CGRectContainsPoint(spRectU, location)) {
        Playermoving = 2;
    }
    if (CGRectContainsPoint(spRectD, location)) {
        Playermoving = 1;
    }
}

- (void)ccTouchesEnded:(UITouch *)touches withEvent:(UIEvent *)event;
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    
    location = [[CCDirector sharedDirector] convertToGL:location];
    if (CGRectContainsPoint(spRectR, location)) {
        Playermoving = 0;
    }
    if (CGRectContainsPoint(spRectL, location)) {
        Playermoving = 0;
    }
    if (CGRectContainsPoint(spRectU, location)) {
        Playermoving = 0;
    }
    if (CGRectContainsPoint(spRectD, location)) {
        Playermoving = 0;
    }
}

- (void)playerMovement: (ccTime) dt
{
    if (Playermoving == 1){
        [_player setPosition:ccp(_player.position.x,_player.position.y - 1)];
    }
    if (Playermoving == 2){
        [_player setPosition:ccp(_player.position.x,_player.position.y + 1)];
    }
    if (Playermoving == 3){
        [_player setPosition:ccp(_player.position.x - 1,_player.position.y)];
    }
    if (Playermoving == 4){
        [_player setPosition:ccp(_player.position.x + 1,_player.position.y)];
    }
}

- (void)ccTouchesMoved:(UITouch *)touches withEvent:(UIEvent *)event;
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    
    location = [[CCDirector sharedDirector] convertToGL:location];
    int Playerstillmoving = 0;
    if (CGRectContainsPoint(spRectR, location)) {
        Playermoving = 4;
        Playerstillmoving = 1;
    }
    if (CGRectContainsPoint(spRectL, location)) {
        Playermoving = 3;
        Playerstillmoving = 1;
    }
    if (CGRectContainsPoint(spRectU, location)) {
        Playermoving = 2;
        Playerstillmoving = 1;
    }
    if (CGRectContainsPoint(spRectD, location)) {
        Playermoving = 1;
        Playerstillmoving = 1;
    }
    if (Playerstillmoving == 0)
    {
        Playermoving = 0;
    }
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}




@end