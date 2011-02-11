#import <Foundation/Foundation.h>
#import "BigInt.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	BigIntRef bi = BigIntNew(20);
	BigIntRef bi2 = BigIntNew(10);
	printf("%ld = %s\n", (long)BigInt32BitInt(bi), BigIntBase10Rep(bi));
	printf("%ld = %s\n", (long)BigInt32BitInt(bi2), BigIntBase10Rep(bi2));
	BigIntRef twelve = BigIntAdd(bi, bi2);
	printf("%ld = %s\n", (long)BigInt32BitInt(twelve), BigIntBase10Rep(twelve));
	BigIntRef subt = BigIntSubtract(bi2, bi);
	printf("%s - %s = %s\n", BigIntBase10Rep(bi2), BigIntBase10Rep(bi), BigIntBase10Rep(subt));
	BigIntRelease(twelve);
	BigIntRelease(bi2);
	BigIntRelease(bi);
	
	BigIntRef orig = BIGINT("-7");
	BigIntRef new = BIGINT("-14");
	printf("Multiplying...\n");
	BigIntRef product = BigIntMultiply(orig, new);
	printf("%s * %s = %s, 32-bit: %ld\n", BigIntBase10Rep(orig), 
		   BigIntBase10Rep(new), BigIntBase10Rep(product), 
		   (long)BigInt32BitInt(product));
	
	BigIntRef sum = BigIntAdd(orig, new);
	printf("%s + %s = %s\n", BigIntBase10Rep(orig),
		   BigIntBase10Rep(new), BigIntBase10Rep(sum));
	
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
	
    [pool drain];
	sleep(1000);
    return 0;
}
