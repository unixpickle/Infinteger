//
//  ANInteger.m
//  Infinteger
//
//  Created by Alex Nichol on 2/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ANInteger.h"


@implementation ANInteger

- (id)initWithString:(NSString *)intString {
	if (self = [super init]) {
		bigInt = BigIntCreateDecimal([intString UTF8String]);
		if (!bigInt) {
			[super dealloc];
			return nil;
		}
	}
	return self;
}
- (id)initWithBigInteger:(ANInteger *)int1 {
	if (self = [super init]) {
		bigInt = BigIntCreateCopy([int1 getBigInt], 0);
	}
	return self;
}
- (id)initWithBigIntRef:(BigIntRef)bi {
	if (self = [super init]) {
		bigInt = BigIntRetain(bi);
	}
	return self;
}
+ (ANInteger *)integerWithInt:(int)i {
	// create a BigInt
	NSString * intString = [NSString stringWithFormat:@"%d", i];
	return [ANInteger integerWithString:intString];
}
+ (ANInteger *)integerWithString:(NSString *)string {
	return [[[ANInteger alloc] initWithString:string] autorelease];
}
- (BigIntRef)getBigInt {
	return bigInt;
}
- (ANInteger *)multiplyBy:(ANInteger *)i1 {
	BigIntRef bir = BigIntMultiply(bigInt, [i1 getBigInt]);
	ANInteger * i = [[ANInteger alloc] initWithBigIntRef:bir];
	BigIntRelease(bir);
	return [i autorelease];
}
- (ANInteger *)addBy:(ANInteger *)i1 {
	BigIntRef bir = BigIntAdd(bigInt, [i1 getBigInt]);
	ANInteger * i = [[ANInteger alloc] initWithBigIntRef:bir];
	BigIntRelease(bir);
	return [i autorelease];
}
- (ANInteger *)subtractBy:(ANInteger *)i1 {
	BigIntRef bir = BigIntSubtract(bigInt, [i1 getBigInt]);
	ANInteger * i = [[ANInteger alloc] initWithBigIntRef:bir];
	BigIntRelease(bir);
	return [i autorelease];
}
- (ANInteger *)divideBy:(ANInteger *)i1 {
	BigIntRef bir = BigIntDivide(bigInt, [i1 getBigInt]);
	ANInteger * i = [[ANInteger alloc] initWithBigIntRef:bir];
	BigIntRelease(bir);
	return [i autorelease];
}
- (BOOL)isLessThan:(ANInteger *)object {
	return BigIntOperatorCheck(bigInt, kBigIntLessThan, [object getBigInt]);
}
- (BOOL)isGreaterThan:(ANInteger *)object {
	return BigIntOperatorCheck(bigInt, kBigIntGreaterThan, [object getBigInt]);
}
- (BOOL)isEqual:(ANInteger *)object {
	// comparative operator
	return BigIntOperatorCheck(bigInt, kBigIntEqual, [object getBigInt]);
}
- (BOOL)isNegative {
	return BigIntFlagIsSet(bigInt, kBigIntFlagNegative);
}
- (NSString *)stringValue {
	return [NSString stringWithFormat:@"%s", BigIntBase10Rep(bigInt)];
}
- (unsigned int)uintValue {
	BigIntDWORD dw = BigInt32BitInt(bigInt);
	return (unsigned int)dw;
}
- (int)intValue {
	BigIntDWORD dw = BigInt32BitInt(bigInt);
	int i = (int)dw;
	if ([self isNegative]) {
		i *= -1;
	}
	return i;
}

- (NSString *)description {
	return [self stringValue];
}

- (void)dealloc {
	BigIntRelease(bigInt);
	[super dealloc];
}

@end
