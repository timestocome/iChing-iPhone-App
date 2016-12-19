//
//  Hexogram.h
//  iChing
//
//  Created by Linda Cobb on 7/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Hexogram : NSObject


-(id)getHexogram:(int)idNumber;

@property (nonatomic, strong) NSString *element1, *element2;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *quote;
@property (nonatomic, strong) NSString *advice;
@property (nonatomic, strong) NSString *one, *two, *three, *four, *five, *six;
@property (nonatomic, strong) NSString *elementName1, *elementName2;
@property (nonatomic, strong) NSString *hexSymbol;  // bottom to top



@end
