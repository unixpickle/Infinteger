/*
 *  BigInt.h
 *  Infinteger
 *
 *  Created by Alex Nichol on 2/9/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include "BitBuffer.h"

#define BIGINT BigIntCreateDecimal

enum EBigIntFlag {
	kBigIntFlagNegative = 1,
	kBigIntFlagNan = 2
};

enum EBigIntOperator {
	kBigIntGreaterThan = 1,
	kBigIntLessThan = 2,
	kBigIntEqual = 4
};


typedef enum EBigIntFlag BigIntFlag;
typedef enum EBigIntOperator BigIntOperator;
typedef char BigBool;
typedef unsigned int BigIntDWORD;

typedef struct {
	// the bits of the number.
	BitBuffer bits;
	// reference count, zero = free.
	int referenceCount;
	// flags used by getter/setter
	// functions!
	int flags;
	// used for returning the Base10 rep
	// NOTE: free this on deletion
	char * b10string;
	// number of binary digits used
	int binDigits;
} _BigInt;

typedef _BigInt *BigIntRef;
#define BBYes 1
#define BBNo 0

// Create a new BigInt with an initial integer value
// with a reference count of 1
//
// @initialValue the initial integer value
//
BigIntRef BigIntNew (BigIntDWORD initialValue);

// Create an exact copy of a BigIntRef, copying all memory.
// the only thing that is not copied is the reference count,
// which will become one.
//
// @bi the BigIntRef to copy
// @shift if not zero will multiply by 2^@shift
//
BigIntRef BigIntCreateCopy (BigIntRef bi, long long shift);

// Create a BigInt from a decimal string.
// 
// @dec the decimal string, for instance: "1234"
//
BigIntRef BigIntCreateDecimal (const char * decstr);

// Return a new BigIntRef with a 1 retain count
// that is the sum of two other bigints.
// This function supports all flags.
//
// @bi the first object
// @bi2 the second object
//
BigIntRef BigIntAdd (BigIntRef bi, BigIntRef bi2);

// Subtract two big ints.
// Function goes @bi - @bi2
//
// @bi first number
// @bi2 second number
//
BigIntRef BigIntSubtract (BigIntRef bi, BigIntRef bi2);

// Return a new BigIntRef with a 1 retain count
// that is the product of two other bigints.
// This function supports all flags.
//
// @bi the first object
// @bi2 the second object
//
BigIntRef BigIntMultiply (BigIntRef bi, BigIntRef bi2);

// Unimplemented division function.  Don't call if
// you dislike consistant NULL values.
BigIntRef BigIntDivide (BigIntRef bi, BigIntRef bi2);

// Returns true or false depending on whether 
// the statement is true or false.
// statement is as follows: first o last
// e.g 3 < 2
//
// @bi1 first number
// @o the operator to compare the first and second number
// @bi2 second number
//
BigBool BigIntOperatorCheck (BigIntRef bi1, BigIntOperator o, BigIntRef bi2);

// Check if a flag is set on a number.
// this is used for detecting if a number
// is negative or not, since every number
// is actually positive as binary, but there
// is a negative flag.
//
// @bi number to test
// @flag flag to check
//
BigBool BigIntFlagIsSet (BigIntRef bi, BigIntFlag flag);

// Get the 32-bit integer for a BigInt.
// This only really works if the number is less
// than 2^32.
//
// @bi the number from which to get a value
//
BigIntDWORD BigInt32BitInt (BigIntRef bi);

// Returns a C-style null terminated string
// that contains the ascii for the number.
// This can be of any length, and therefore
// is suggested over BigInt32BitInt.
//
// @bi the number from which to get a value
//
const char * BigIntBase10Rep (BigIntRef bi);

// Reference counting functions.
// call retain to add a reference
// and release to remove one.
// By default the retain count is one,
// so one Release() will free.
BigIntRef BigIntRetain (BigIntRef bi);
void BigIntRelease (BigIntRef bi);
