//
//  WHLoginObject.h
//  WHNewsReader
//
//  Created by Mason Saucier on 5/15/14.
//  Copyright (c) 2014 Washington Herald. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WHUserObject.h"

@interface WHLoginObject : NSObject

@property NSString *accessToken;
@property WHUserObject *user;

@end
