# Infinteger

Infinteger is a C library that can be used to achieve infinitely large integers.  Since it is still being debugged, the code might still have a few bugs to work out.  The major functionality of the library is done, as you can see by building the project and running it.  

Here is my original to-do list for Infinteger:

1. Addition
2. Multiplication
3. Subtraction
4. Division
5. Negative numbers (or flags, rather).
6. Comparative operators (e.g >, <, =)
7. Modulus
8. An Objective-C wrapper

So far all of these are done, except for 7, and 8, which are not required for this library to be used.  Modulus is already pretty easy to calculate, so there definitely will be a modulus function added to the next release.

The number objects themselves are immutable, and therefore every operation must allocate a new object.  When I say object of course, I mean structure, since we know that C does not have object orientation.

## The Basics

There is a structure, called BigIntRef (which is actually a reference to a structure), that represents a BigInt object.  To create one, you can use one of three functions:

    BigIntRef bi = BigIntNew(23);
    BigIntRef bi = BigIntCreateDecimal("15");
    BigIntRef bi = BigIntCreateCopy(bi1, 0);

I suggest using the second one, BigIntCreateDecimal, since it allows you to pass a string that can be of any length.  This means that there is no aspect in which you are limited by the size of a C-style integer.

## Operations

Currently you can perform multiplication, addition, and subtraction.  Division will be the last one added, and should not be that hard to do.  Below are a few examples of how to do different mathematical operations.

Here is the code for a simple BigInt addition operation:

    BigIntRef people = BigIntAdd(females, males);

Note that every BigInt returned by a function is retained exactly once, and therefore you must call <tt>BigIntRelease()</tt> on the people variable in the previous example.  Likewise, multiplication is very similar:

    BigIntRef area = BigIntMultiply(height, width);

Multiplication respects the properties of negatives.  Therefore a negative times a negative will output as a positive.  Subtraction is similar to addition, and therefore the call follows the standard:

    BigIntRef dx = BigIntSubtract(x2, x1);

That call will subtract x1 from x2, making <tt>x2 - x1</tt>

## Comparing Numbers

There are currently three comparative operations that you can perform on a BigInt object.  Theses are greater than, less than, and equal to.  The function to do this is declared as follows:

    BigBool BigIntOperatorCheck(BigIntRef bi1, BigIntOperator o, BigIntRef bi2);

The BigBool is just the smallest datatype that C has, which in this case is a byte.  The values for this are <tt>BBYes</tt>, which is 1, and <tt>BBNo</tt>, which is 0.  You can use the <tt>BigIntOperatorCheck</tt> function as follows:

    BigIntOperatorCheck(bi1, kBigIntEqual, bi2)

This will check if <tt>bi1 = bi2</tt>.  All three operators take negation into account.

## Output

Since BigInt structures can hold numbers well over the limit of 32bit integers, printing out as an <tt>unsigned long long</tt> is not sufficient to output ANY BigInt object.  That is why there is a <tt>BigIntBase10Rep</tt> function.  This function returns an ASCII C-style string, escaped with a null character.  This string represents the base10 number stored in a BigInt, and therefore can be printed directly in a format using %s.

The string returned by this function does not need to be freed, because this will occur automatically when the last <tt>BigIntRelease()</tt> is called on the BigInt it came from.  This means that, if you intend on using a base10 representation string for a long period of time, long after you free the BigInt, you must first create a copy so that it will not be freed when the BigInt is.

The standard usage of this is as follows:

    printf("bi = %s\n", BigIntBase10Rep(bi));

Where the variable <tt>bi</tt> is the BigInt of which to print.

## Notes

Addition, subtraction, multiplication, and division are all complete.  The basic operators are present, but the more complex ones such as <= and >= are not there.  The only way to check if a number is negative is to get the base 10 string for it, or check the flag using <tt>BigIntFlagIsSet</tt>.  There are no known leaks, so if you find one, please inform me.
