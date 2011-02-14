//
//  ANInteger.h
//  Infinteger
//
//  Created by Alex Nichol on 2/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BigInt.h"

@interface ANInteger : NSObject {
	BigIntRef bigInt;
}

- (id)initWithString:(NSString *)intString;
- (id)initWithBigInteger:(ANInteger *)int1;
- (id)initWithBigIntRef:(BigIntRef)bi;
+ (ANInteger *)integerWithInt:(int)i;
+ (ANInteger *)integerWithString:(NSString *)string;
- (BigIntRef)getBigInt;
- (ANInteger *)multiplyBy:(ANInteger *)i1;
- (ANInteger *)addBy:(ANInteger *)i1;
- (ANInteger *)subtractBy:(ANInteger *)i1;
- (ANInteger *)divideBy:(ANInteger *)i1;
- (BOOL)isLessThan:(ANInteger *)object;
- (BOOL)isGreaterThan:(ANInteger *)object;
- (BOOL)isEqual:(ANInteger *)object;
- (BOOL)isNegative;
- (NSString *)stringValue;
- (unsigned int)uintValue;
- (int)intValue;

@end
