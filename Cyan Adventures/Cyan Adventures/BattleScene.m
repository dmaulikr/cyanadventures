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

#pragma mark - BattleScene

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
        CCSprite *dpad = [CCSprite spriteWithFile:@"dpad.png"];
        [dpad setPosition:ccp([dpad contentSize].width / 2,[dpad contentSize].height / 2)];
        [self addChild:dpad];
        spRectR = CGRectMake(90,45,45,45);
        spRectD = CGRectMake(45,0,45,45);
        spRectL = CGRectMake(0,45,45,45);
        spRectU = CGRectMake(45,90,45,45);
        
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