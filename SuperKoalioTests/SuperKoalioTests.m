//
//  SuperKoalioTests.m
//  SuperKoalioTests
//
//  Created by Jake Gundersen on 12/27/13.
//  Copyright (c) 2013 Razeware, LLC. All rights reserved.
//

#import <Kiwi.h>
#import "GameLevelScene.h"
#import "Player.h"
#import "JSTileMap.h"

@interface GameLevelScene (internalMethods)

- (CGRect)tileRectFromTileCoords:(CGPoint)tileCoords;
- (NSInteger)tileGIDAtTileCoord:(CGPoint)coord forLayer:(TMXLayer *)layer;
- (void)checkForAndResolveCollisionsForPlayer:(Player *)player forLayer:(TMXLayer *)layer;

@end

SPEC_BEGIN(SuperKoalio)

describe(@"Game Level Scene", ^{
    it(@"When player collides with ground", ^{
        GameLevelScene *backgroundScene = [[GameLevelScene alloc] initWithSize:CGSizeMake(1000, 1000)];
        
        Player *player = [[Player alloc] init];
        player.position = CGPointMake(5, 5);
        [player stub:@selector(collisionBoundingBox) andReturn:theValue(CGRectMake(0, 0, 10, 20))];
        
        TMXLayer *layer = [TMXLayer nullMock];
        [layer stub:@selector(coordForPoint:) andReturn:theValue(CGPointMake(5, 5))];
        
        [backgroundScene stub:@selector(tileGIDAtTileCoord:forLayer:) andReturn:theValue(1)];
        [backgroundScene stub:@selector(tileRectFromTileCoords:) andReturn:theValue(CGRectMake(0, 0, 1000, 6))];
        
        [backgroundScene checkForAndResolveCollisionsForPlayer:player forLayer:layer];
        [[theValue(player.position) should] equal:theValue(CGPointMake(5, 6))];
    });
});


SPEC_END
