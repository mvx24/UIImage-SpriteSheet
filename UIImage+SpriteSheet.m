//
//  UIImage+SpriteSheet.m
//
//  Copyright (c) 2012 Symbiotic Software LLC. All rights reserved.
//

#import "UIImage+SpriteSheet.h"

@implementation UIImage (SpriteSheet)

- (NSArray *)spritesSized:(CGSize)frameSize
{
	CGFloat startX, startY;
	NSUInteger rows, cols;
	CGFloat x, y, width, height;
	CGImageRef spriteImageRef;
	NSMutableArray *spritesArray;

	// Calculate the size and where the sprites start (if there is padding)
	width = self.size.width;
	height = self.size.height;
	cols = (NSUInteger)(width / frameSize.width);
	rows = (NSUInteger)(height / frameSize.height);
	startX = (width - (frameSize.width * (CGFloat)cols))/2.0f;
	startY = (height - (frameSize.height * (CGFloat)rows))/2.0f;

	// Adjust for the scale
	width *= self.scale;
	height *= self.scale;
	startX *= self.scale;
	startY *= self.scale;
	frameSize.width *= self.scale;
	frameSize.height *= self.scale;
	
	// Divide the image into sprites
	spritesArray = [NSMutableArray arrayWithCapacity:cols * rows];
	for(y = startY; y < height; y += frameSize.height)
	{
		for(x = startX; x < width; x += frameSize.width)
		{
			spriteImageRef = CGImageCreateWithImageInRect(self.CGImage, (CGRect){.size=frameSize, .origin=CGPointMake(x, y)});
			[spritesArray addObject:[UIImage imageWithCGImage:spriteImageRef]];
			CGImageRelease(spriteImageRef);
		}
	}

	return spritesArray;
}

@end
