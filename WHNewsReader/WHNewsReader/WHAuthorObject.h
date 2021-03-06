//
//  WHAuthorObject.h
//  WHNewsReader
//
//  Created by Mason Saucier on 5/12/14.
//
//

#import <Foundation/Foundation.h>
#import "NSObject+ObjectMap.h"

@interface WHAuthorObject : NSObject

@property NSString *Id;
@property NSString *firstName;
@property NSString *lastName;
@property NSString *imageUrl;
@property NSString *username;
@property NSString *email;
@property NSString *position;
@property BOOL isWriter;

@end
