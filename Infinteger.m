#import <Foundation/Foundation.h>
#import "BigInt.h"
#import "ANInteger.h"

void CLibraryTesting ();
void ObjCLibraryTesting ();

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	printf("*******************************\n\
Entering C library test phase.\n\
*******************************\n\n");
	CLibraryTesting();
	printf("\n****************************************\n\
Entering Objective-C library test phase.\n\
****************************************\n\n");
	ObjCLibraryTesting();
	
    [pool drain];
	printf("Sleeping for 1000 seconds (for leak testing)\n");
	sleep(1000);
    return 0;
}

void ObjCLibraryTesting() {
	// test the objective-c wrapper for the library
	ANInteger * i = [ANInteger integerWithString:@"123"];
	NSLog(@"%@ = %d", [i stringValue], [i intValue]);
	ANInteger * prod = [i multiplyBy:[ANInteger integerWithString:@"2"]];
	NSLog(@"%@ * 2 = %@", [i stringValue], [prod stringValue]);
	// we have testing simple multiplication.
	// now test some division
	ANInteger * num1 = [ANInteger integerWithString:@"-120"];
	ANInteger * num2 = [ANInteger integerWithString:@"12"];
	ANInteger * quotient = [num1 divideBy:num2];
	NSLog(@"%@ / %@ ~= %@", [num1 stringValue], [num2 stringValue], [quotient stringValue]);
	// print out the clause
	if ([num1 isGreaterThan:num2]) {
		NSLog(@"%@ > %@", [num1 stringValue], [num2 stringValue]);
	} else if ([num1 isLessThan:num2]) {
		NSLog(@"%@ < %@", [num1 stringValue], [num2 stringValue]);
	} else if ([num1 isEqual:num2]) {
		NSLog(@"%@ = %@", [num1 stringValue], [num2 stringValue]);
	} else {
		NSLog(@"Error comparing %@ and %@", [num1 stringValue], [num2 stringValue]);
	}
	// test with integers
	ANInteger * bi = [ANInteger integerWithInt:-30];
	NSLog(@"%@ * 2 = %@", [bi stringValue], [[bi multiplyBy:[ANInteger integerWithInt:2]] stringValue]);
}

void CLibraryTesting () {
	printf("Basics ...\n");
	BigIntRef bi = BigIntNew(20);
	BigIntRef bi2 = BigIntNew(10);
	printf("%ld = %s\n", (long)BigInt32BitInt(bi), BigIntBase10Rep(bi));
	printf("%ld = %s\n", (long)BigInt32BitInt(bi2), BigIntBase10Rep(bi2));
	BigIntRef twelve = BigIntAdd(bi, bi2);
	printf("%ld = %s\n", (long)BigInt32BitInt(twelve), BigIntBase10Rep(twelve));
	printf("Subtraction ...\n");
	BigIntRef subt = BigIntSubtract(bi2, bi);
	printf("%s - %s = %s\n", BigIntBase10Rep(bi2), BigIntBase10Rep(bi), BigIntBase10Rep(subt));
	BigIntRelease(twelve);
	BigIntRelease(bi2);
	BigIntRelease(bi);
	BigIntRelease(subt);
	
	
	BigIntRef orig = BIGINT("-2");
	BigIntRef new = BIGINT("10");
	
	printf("Multiplying...\n");
	BigIntRef product = BigIntMultiply(orig, new);
	printf("%s * %s = %s, 32-bit: %ld\n", BigIntBase10Rep(orig), 
		   BigIntBase10Rep(new), BigIntBase10Rep(product), 
		   (long)BigInt32BitInt(product));
	
	printf("Adding ...\n");
	BigIntRef sum = BigIntAdd(orig, new);
	printf("%s + %s = %s\n", BigIntBase10Rep(orig),
		   BigIntBase10Rep(new), BigIntBase10Rep(sum));
	
	printf("Operators ...\n");
	if (BigIntOperatorCheck(orig, kBigIntGreaterThan, new)) {
		printf("%s > %s\n", BigIntBase10Rep(orig), BigIntBase10Rep(new));
	} else if (BigIntOperatorCheck(orig, kBigIntLessThan, new)) {
		printf("%s < %s\n", BigIntBase10Rep(orig), BigIntBase10Rep(new));
	} else {
		printf("%s = %s\n", BigIntBase10Rep(orig), BigIntBase10Rep(new));
	}
	
	BigIntRelease(product);
	BigIntRelease(sum);
	BigIntRelease(orig);
	BigIntRelease(new);

	printf("Division testing ...\n");
	BigIntRef numerator = BIGINT("4000");
	BigIntRef denominator = BIGINT("200");
	BigIntRef quotient = BigIntDivide(numerator, denominator);
	printf("%s / %s = %s\n", BigIntBase10Rep(numerator), 
		   BigIntBase10Rep(denominator), BigIntBase10Rep(quotient));
	BigIntRelease(numerator);
	BigIntRelease(denominator);
	BigIntRelease(quotient);
}

