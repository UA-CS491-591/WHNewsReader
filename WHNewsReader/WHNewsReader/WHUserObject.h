//
//  WHUserObject.h
//  WHNewsReader
//
//  Created by Mason Saucier on 5/15/14.
//  Copyright (c) 2014 Washington Herald. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHUserObject : NSObject

@property NSString *Id;
@property NSString *firstName;
@property NSString *lastName;
@property NSString *username;
@property NSString *email;
@property NSString *position;
@property BOOL isWriter;
@property NSString *imageUrl;


@end
