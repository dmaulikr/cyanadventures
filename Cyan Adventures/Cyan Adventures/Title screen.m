//
//  Title screen.m
//  Tell Me A Story
//
//  Created by Michael Brand on 04/10/2012.
//
//

#import "Title screen.h"
#import "BattleScene.h"
#import "StoryGameFirstPanel.h"

@implementation Title_screen

+(id) scene;

{
    CCScene *scene = [CCScene node];
    
    Title_screen *layer = [Title_screen node];
    
    [scene addChild: layer];
    
    return scene;
}

-(id) init
{
    
    if( (self=[super init] )) {
        
        CCLayer *menuLayer = [[CCLayer alloc] init];
        [self addChild:menuLayer];
        
        background = [CCSprite spriteWithFile:@"menubackground.png"];
        [background setPosition:ccp([background contentSize].width / 2,[background contentSize].height /2)];
        [self addChild:background];
        [self schedule:@selector(backgroundanimation:) interval:0];
        backgroundanimationswitcher = 0;
        
        CCSprite *header = [CCSprite spriteWithFile:@"banner.png"];
        [header setPosition:ccp(240,240)];
        [self addChild:header];
        
        cloud = [CCSprite spriteWithFile:@"cloud.png"];
        [cloud setPosition:ccp( 320 +[cloud contentSize].width /2, 260 + [cloud contentSize].height /2)];
        [self addChild:cloud];
        
        CCSprite * startButton = [CCSprite spriteWithFile:@"myfirstbutton.png"];
        [startButton setPosition:ccp( 240, 180)];
        [self addChild:startButton];
        menuChoice1 = CGRectMake(startButton.position.x - ([startButton contentSize].width /2),startButton.position.y - ([startButton contentSize].height /2),[startButton contentSize].width,[startButton contentSize].height);
      //  CCMenuItemImage *startButton = [CCMenuItemImage itemFromNormalImage:@"myfirstbutton.png"
      //                                  selectedImage:@"myfirstbutton_selected.png"
      //                                  target:self
      //                                  selector:@selector(startGame:)];
      //
      //  CCMenuItemImage *secondButton = [CCMenuItemImage itemFromNormalImage:@"mysecondbutton.png"
      //                                  selectedImage:@"mysecondbutton_selected.png"
      //                                  target:self
      //                                  selector:@selector(secondChoice:)];
      //
      //  CCMenuItemImage *thirdButton = [CCMenuItemImage itemFromNormalImage:@"mythirdbutton.png"
      //                                  selectedImage:@"mythirdbutton_selected.png"
      //                                  target:self
      //                                  selector:@selector(thirdChoice:)];
      //
      //  CCMenu * menu = [CCMenu menuWithItems: startButton,secondButton,thirdButton, nil];
      //
      //  [menuLayer addChild: menu];
      //  [menu alignItemsVertically];
        [self setIsTouchEnabled:TRUE];    }
    return self;
}

- (void)backgroundanimation: (ccTime) dt
{
    
    if (background.position.x <= [background contentSize].width /2 - 120)
    {
        backgroundanimationswitcher = 1;
    }
    if (background.position.x >= [background contentSize].width /2)
    {
        backgroundanimationswitcher = 0;
    }
    if (backgroundanimationswitcher == 0)
    {
        [background setPosition:ccp(background.position.x - 0.1,[background contentSize].height /2)];
    }
    if (backgroundanimationswitcher == 1)
    {
        [background setPosition:ccp(background.position.x + 0.1,[background contentSize].height /2)];
    }
[cloud setPosition:ccp(cloud.position.x - 1,cloud.position.y)];
if (cloud.position.x <= -30) {
    [cloud setPosition:ccp(490,cloud.position.y)];
}
}

- (void) startGame: (id) sender
{
   // [[CCDirector sharedDirector] replaceScene:[BattleScene scene]];
    [[CCDirector sharedDirector] replaceScene: [StoryGameFirstPanel scene]];
}

- (void) secondChoice: (id) sender
{
    NSLog(@"second button pressed");
}

- (void) thirdChoice: (id) sender
{
    NSLog(@"third button pressed");
}

- (void)ccTouchesBegan:(UITouch *)touches withEvent:(UIEvent *)event;
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    
    location = [[CCDirector sharedDirector] convertToGL:location];
    if (CGRectContainsPoint(menuChoice1, location)) {
    [[CCDirector sharedDirector] replaceScene: [StoryGameFirstPanel scene]];
    }
}

- (void)ccTouchesEnded:(UITouch *)touches withEvent:(UIEvent *)event;
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:[touch view]];
}


- (void) dealloc
{
    
    [super dealloc];
}
@end
