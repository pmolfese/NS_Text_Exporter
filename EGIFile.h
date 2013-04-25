//
//  EGIFile.h
//  NS_Text_Export
//
//  Created by Peter Molfese on 4/11/06.
//  Copyright 2006 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface EGIFile : NSOperation 
{
	NSString *name;
	NSString *path;
}
@property(readwrite,copy)NSString *name;
@property(readwrite,copy)NSString *path;
-(void)setName;
-(void)main;


@end
