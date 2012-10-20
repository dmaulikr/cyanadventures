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
        //Background
        background = [CCSprite spriteWithFile:@"menubackground.png"];
        [background setPosition:ccp([background contentSize].width / 2,[background contentSize].height /2)];
        [self addChild:background];
        [self schedule:@selector(backgroundupdate:) interval:0];
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
        [_player setPosition:ccp(160,120 + (_player.contentSize.height / 2))];
        [self addChild:_player];
        Playermoving = 0;
        flameanimation1 = [[CCTextureCache sharedTextureCache] addImage:@"stickfigure2.png"];
        flameanimation2 = [[CCTextureCache sharedTextureCache] addImage:@"stickfigure3.png"];
        stationary = [[CCTextureCache sharedTextureCache] addImage:@"stickfigure.png"];
        ducking = [[CCTextureCache sharedTextureCache] addImage:@"stickfigureducking.png"];
        

        
    
        //Setting Up Arrow Buttons
        CCSprite *dpad = [CCSprite spriteWithFile:@"dpad.png"];
        [dpad setPosition:ccp([dpad contentSize].width / 2,[dpad contentSize].height / 2)];
        [self addChild:dpad];
        spRectR = CGRectMake(90,45,45,45);
        spRectD = CGRectMake(45,0,45,45);
        spRectL = CGRectMake(0,45,45,45);
        spRectU = CGRectMake(45,90,45,45);
        spRectRD = CGRectMake(90,0,45,45);
        spRectRU = CGRectMake(90,90,45,45);
        spRectLD = CGRectMake(0,0,45,45);
        spRectLU = CGRectMake(0,90,45,45);
        
        //Setting Up Buttons
        bluebutton = [CCSprite spriteWithFile:@"bluebutton.png"];
        [bluebutton setPosition:ccp((size.width - 140) - [bluebutton contentSize].width/2, 10 + [bluebutton contentSize].height /2)];
        [self addChild:bluebutton];
        spRectBB = CGRectMake(bluebutton.position.x -([bluebutton contentSize].width / 2),bluebutton.position.y - ([bluebutton contentSize].height / 2),[bluebutton contentSize].width, [bluebutton contentSize].height );
        
        redbutton = [CCSprite spriteWithFile:@"redbutton.png"];
        [redbutton setPosition:ccp((size.width - 70) - [redbutton contentSize].width/2, 20 + [redbutton contentSize].height /2)];
        [self addChild:redbutton];
        spRectRB = CGRectMake(redbutton.position.x -([redbutton contentSize].width / 2),redbutton.position.y - ([redbutton contentSize].height / 2),[redbutton contentSize].width, [redbutton contentSize].height );
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
        Playermoving = 2;
    }
    if (CGRectContainsPoint(spRectL, location)) {
        Playermoving = 4;
    }
    if (CGRectContainsPoint(spRectU, location)) {
        Playermoving = 1;
    }
    if (CGRectContainsPoint(spRectD, location)) {
        Playermoving = 3;
        Playerducking = 1;
    }
    if (CGRectContainsPoint(spRectRU, location)) {
        Playermoving = 5;
    }
    if (CGRectContainsPoint(spRectRD, location)) {
        Playermoving = 6;
    }
    if (CGRectContainsPoint(spRectLD, location)) {
        Playermoving = 7;
    }
    if (CGRectContainsPoint(spRectLU, location)) {
        Playermoving = 8;
    }
    if (CGRectContainsPoint(spRectBB, location)) {
        if (ButtonPressLife == 0){
        ButtonPressed = 1;
        }
    }
    if (CGRectContainsPoint(spRectRB, location)) {
        if (ButtonPressLife == 0){
            ButtonPressed = 2;
        }
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
        Playerducking = 0;
        [_player setTexture:stationary];
        [_player setTextureRect:CGRectMake(0, 0, stationary.contentSize.width, stationary.contentSize.height)];
    }
    if (CGRectContainsPoint(spRectRU, location)) {
        Playermoving = 0;
    }
    if (CGRectContainsPoint(spRectRD, location)) {
        Playermoving = 0;
    }
    if (CGRectContainsPoint(spRectLD, location)) {
        Playermoving = 0;
    }
    if (CGRectContainsPoint(spRectLU, location)) {
        Playermoving = 0;
    }
}

- (void)playerMovement: (ccTime) dt
{
    //PlayerControls
    if ((Jumping == 0) && (SlidingL == 0) && (SlidingR == 0)){
        if (Playermoving == 1){
            Jumping = 1;
        }
        if (Playermoving == 2){
            [_player setPosition:ccp(_player.position.x + 3,_player.position.y)];
        }
        if (Playermoving == 3){
            [_player setTexture:ducking];
            [_player setTextureRect:CGRectMake(0, 0, ducking.contentSize.width, ducking.contentSize.height)];
            Playerducking = 1;
        }
        if (Playermoving == 4){
            [_player setPosition:ccp(_player.position.x - 3,_player.position.y)];
        }
        if (Playermoving == 5){
            Jumping = 1;
            JumpingR = 1;
        }
        if (Playermoving == 6){
            SlidingR = 1;
        }
        if (Playermoving == 7){
            SlidingL = 1;
        }
        if (Playermoving == 8){
            Jumping = 1;
            JumpingL = 1;
        }
    }
    
    if (Jumping >0){
        if (Jumping > 10){
                        [_player setPosition:ccp(_player.position.x,_player.position.y - 3)];
            Jumping = Jumping + 1;
            if (JumpingL == 1){
                        [_player setPosition:ccp(_player.position.x - 3,_player.position.y)];
            }
            if (JumpingR == 1){
                [_player setPosition:ccp(_player.position.x + 3,_player.position.y)];
            }
        }
        if (Jumping <=10){
            Jumping = Jumping + 1;
            [_player setPosition:ccp(_player.position.x,_player.position.y + 3)];
            if (JumpingL == 1){
                [_player setPosition:ccp(_player.position.x - 3,_player.position.y)];
            }
            if (JumpingR == 1){
                [_player setPosition:ccp(_player.position.x + 3,_player.position.y)];
            }
        }
        if (Jumping ==21){
            Jumping = 0;
            JumpingL = 0;
            JumpingR = 0;
        }
    }
    
    if(SlidingL >= 1){
        [_player setTexture:ducking];
        [_player setTextureRect:CGRectMake(0, 0, ducking.contentSize.width, ducking.contentSize.height)];
                        [_player setPosition:ccp(_player.position.x - 3,_player.position.y)];
        if(SlidingL == 1){
            _player.flipX = YES;
        }
        SlidingL = SlidingL + 1;
        if (SlidingL == 30){
            SlidingL = 0;
            [_player setTexture:stationary];
            [_player setTextureRect:CGRectMake(0, 0, stationary.contentSize.width, stationary.contentSize.height)];
        }
    }
    if(SlidingR >= 1){
        [_player setTexture:ducking];
        [_player setTextureRect:CGRectMake(0, 0, ducking.contentSize.width, ducking.contentSize.height)];
        [_player setPosition:ccp(_player.position.x + 3,_player.position.y)];
        if(SlidingR == 1){
            _player.flipX = NO;
        }
        SlidingR = SlidingR + 1;
        if (SlidingR == 30){
            SlidingR = 0;
            [_player setTexture:stationary];
            [_player setTextureRect:CGRectMake(0, 0, stationary.contentSize.width, stationary.contentSize.height)];
        }
    }
    
    //Screen Boundaries
    if (_player.position.x <= 0 + ([_player contentSize].width / 2)){
        [_player setPosition:ccp(0 + ([_player contentSize].width / 2),_player.position.y)];
    }
    if (_player.position.x >= 480 - ([_player contentSize].width / 2)){
        [_player setPosition:ccp(480 - ([_player contentSize].width /2),_player.position.y)];
    }
    if (_player.position.y <= 120 + ([_player contentSize].height / 2)){
        [_player setPosition:ccp(_player.position.x,120 + ([_player contentSize].height /2))];
    }
    if (_player.position.y >= 320 -([_player contentSize].height /2)){
        [_player setPosition:ccp(_player.position.x,320 - ([_player contentSize].height /2))];
    }
    
    //BattleControls
    if (Playermoving ==0){
        int ButtonLifeEnd = 0;
        if (ButtonPressed >= 1) {
            if (ButtonPressLife == 0){
                [_player setTexture:flameanimation1];
            }
            if (ButtonPressLife == 5){
                [_player setTexture:flameanimation2];
                if (ButtonPressed == 1){
                Flame = 1;
                }
                if (ButtonPressed == 2){
                    Blizzardstorm = 1;
                }
            }
            if (ButtonPressLife == 10){
                [_player setTexture:flameanimation1];
            }
            if (ButtonPressLife == 15){
                                [_player setTexture:stationary];
                ButtonLifeEnd = 1;
            }
            ButtonPressLife = ButtonPressLife + 1;
            if (ButtonLifeEnd == 1){
                ButtonPressLife = 0;
                ButtonPressed = 0;
            }
        }
    }
    
    //Flame
    if (Flame == 1){
        if (Spellcountdown == 0){
            flame = [CCSprite spriteWithFile:(@"flame.png")];
            [flame setPosition:ccp(_player.position.x + 60, _player.position.y)];
            [self addChild: flame];
            Spellcountdown = 10;
        }
        if (Spellcountdown >= 1){
            Spellcountdown = Spellcountdown - 1;
        }
        if (Spellcountdown == 0) {
            [flame removeFromParentAndCleanup:TRUE];
            Flame = 0;
        }
    }
    //Blizzard Storm
    if (Blizzardstorm == 1){
        if (Spellcountdown == 0){
            int i = 0;
                blizzardstorm1 = [CCSprite spriteWithFile:(@"snow.png")];
                [blizzardstorm1 setPosition:ccp(_player.position.x + (i), 320 - (blizzardstorm1.contentSize.height / 2))];
                [self addChild: blizzardstorm1];
            i = i + 40;
            blizzardstorm2 = [CCSprite spriteWithFile:(@"snow.png")];
            [blizzardstorm2 setPosition:ccp(_player.position.x + (i), 320 - (blizzardstorm2.contentSize.height / 2) + i)];
            [self addChild: blizzardstorm2];
            i = i + 40;
            blizzardstorm3 = [CCSprite spriteWithFile:(@"snow.png")];
            [blizzardstorm3 setPosition:ccp(_player.position.x + (i), 320 - (blizzardstorm3.contentSize.height / 2) + (i / 2))];
            [self addChild: blizzardstorm3];
            i = i + 40;
            blizzardstorm4 = [CCSprite spriteWithFile:(@"snow.png")];
            [blizzardstorm4 setPosition:ccp(_player.position.x + (i), 320 - (blizzardstorm4.contentSize.height / 2) + (i * 2))];
            [self addChild: blizzardstorm4];
            i = i + 40;
            blizzardstorm5 = [CCSprite spriteWithFile:(@"snow.png")];
            [blizzardstorm5 setPosition:ccp(_player.position.x + (i), 320 - (blizzardstorm5.contentSize.height / 2) + (i * 1.5))];
            [self addChild: blizzardstorm5];
            i = i + 40;
            blizzardstorm6 = [CCSprite spriteWithFile:(@"snow.png")];
            [blizzardstorm6 setPosition:ccp(_player.position.x + (i), 320 - (blizzardstorm6.contentSize.height / 2) + (i + 1))];
            [self addChild: blizzardstorm6];
            i = i + 40;
                Spellcountdown = 50;
        }
        if (Spellcountdown >= 1){
            [blizzardstorm1 setPosition:ccp(blizzardstorm1.position.x + 5, blizzardstorm1.position.y - 8 )];
            [blizzardstorm2 setPosition:ccp(blizzardstorm2.position.x + 4, blizzardstorm2.position.y - 9 )];
                        [blizzardstorm3 setPosition:ccp(blizzardstorm3.position.x + 10, blizzardstorm3.position.y - 8 )];
                        [blizzardstorm4 setPosition:ccp(blizzardstorm4.position.x + 1, blizzardstorm4.position.y - 12 )];
                        [blizzardstorm5 setPosition:ccp(blizzardstorm5.position.x + 7, blizzardstorm5.position.y - 10 )];
                        [blizzardstorm6 setPosition:ccp(blizzardstorm6.position.x + 2, blizzardstorm6.position.y - 8 )];
            Spellcountdown = Spellcountdown - 1;
        }
        if (Spellcountdown == 0) {
            [blizzardstorm1 removeFromParentAndCleanup:TRUE];
            [blizzardstorm2 removeFromParentAndCleanup:TRUE];
            [blizzardstorm3 removeFromParentAndCleanup:TRUE];
            [blizzardstorm4 removeFromParentAndCleanup:TRUE];
            [blizzardstorm5 removeFromParentAndCleanup:TRUE];
            [blizzardstorm6 removeFromParentAndCleanup:TRUE];
            Blizzardstorm = 0;
        }
    }
    
}

- (void)ccTouchesMoved:(UITouch *)touches withEvent:(UIEvent *)event;
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    
    location = [[CCDirector sharedDirector] convertToGL:location];
    int Playerstillmoving = 0;
    if (CGRectContainsPoint(spRectR, location)) {
        Playermoving = 2;
        Playerstillmoving = 1;
    }
    if (CGRectContainsPoint(spRectL, location)) {
        Playermoving = 4;
        Playerstillmoving = 1;
    }
    if (CGRectContainsPoint(spRectU, location)) {
        Playermoving = 1;
        Playerstillmoving = 1;
    }
    if (CGRectContainsPoint(spRectD, location)) {
        Playermoving = 3;
        Playerstillmoving = 1;
        Playerducking = 1;
    }
    if (CGRectContainsPoint(spRectRU, location)) {
        Playermoving = 5;
        Playerstillmoving = 1;
    }
    if (CGRectContainsPoint(spRectRD, location)) {
        Playermoving = 6;
        Playerstillmoving = 1;
    }
    if (CGRectContainsPoint(spRectLD, location)) {
        Playermoving = 7;
        Playerstillmoving = 1;
    }
    if (CGRectContainsPoint(spRectLU, location)) {
        Playermoving = 8;
        Playerstillmoving = 1;
    }
    if (Playerstillmoving == 0)
    {
        Playermoving = 0;
        Playerducking = 0;
    }
    if (Playerducking == 0){
        [_player setTexture:stationary];
        [_player setTextureRect:CGRectMake(0, 0, stationary.contentSize.width, stationary.contentSize.height)];
    }
}

-(void) backgroundupdate: (ccTime) dt {
    if (background.position.x < 300) {
        if (_player.position.x <= 150){
            [_player setPosition:ccp(_player.position.x + 5, _player.position.y)];
            [background setPosition:ccp(background.position.x + 5, background.position.y)];
            if (background.position.x > 300){
                int oldx = background.position.x;
                [background setPosition:ccp(300,background.position.y)];
                [_player setPosition:ccp(_player.position.x + (background.position.x - oldx),_player.position.y)];
            }
        }
    }
    if (background.position.x >= 180) {
        if (_player.position.x > 320){
            [_player setPosition:ccp(_player.position.x - 5, _player.position.y)];
            [background setPosition:ccp(background.position.x - 5, background.position.y)];
            if (background.position.x < 180){
                int oldx = background.position.x;
                [background setPosition:ccp(180,background.position.y)];
                [_player setPosition:ccp(_player.position.x + (background.position.x - oldx),_player.position.y)];
            }
        }
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