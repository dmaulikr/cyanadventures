//
//  Title screen.m
//  Tell Me A Story
//
//  Created by Michael Brand on 04/10/2012.
//
//

#import "Title screen.h"
#import "BattleScene.h"

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
        
        CCMenuItemImage *startButton = [CCMenuItemImage itemFromNormalImage:@"myfirstbutton.png"
                                        selectedImage:@"myfirstbutton_selected.png"
                                        target:self
                                        selector:@selector(startGame:)];
        
        CCMenuItemImage *secondButton = [CCMenuItemImage itemFromNormalImage:@"mysecondbutton.png"
                                        selectedImage:@"mysecondbutton_selected.png"
                                        target:self
                                        selector:@selector(secondChoice:)];
        
        CCMenuItemImage *thirdButton = [CCMenuItemImage itemFromNormalImage:@"mythirdbutton.png"
                                        selectedImage:@"mythirdbutton_selected.png"
                                        target:self
                                        selector:@selector(thirdChoice:)];
        
        CCMenu *menu = [CCMenu menuWithItems: startButton,secondButton,thirdButton, nil];
        
        [menuLayer addChild: menu];
        [menu alignItemsVertically];
        [self setIsTouchEnabled:TRUE];    }
    return self;
}

- (void) startGame: (id) sender
{
   [[CCDirector sharedDirector] replaceScene:[BattleScene scene]];
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
