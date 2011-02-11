# Infinteger

This library is currently being developed, and therefore is not yet fully functional.  The features it will include are:

1. Addition
2. Multiplication
3. Subtraction
4. Division
5. Negative numbers (or flags, rather).
6. Comparative operators (e.g >, <, =)

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

## Output

Since BigInt structures can hold numbers well over the limit of 32bit integers, printing out as an <tt>unsigned long long</tt> is not sufficient to output ANY BigInt object.  That is why there is a <tt>BigIntBase10Rep</tt> function.  This function returns an ASCII C-style string, escaped with a null character.  This string represents the base10 number stored in a BigInt, and therefore can be printed directly in a format using %s.

The string returned by this function does not need to be freed, because this will occur automatically when the last <tt>BigIntRelease()</tt> is called on the BigInt it came from.  This means that, if you intend on using a base10 representation string for a long period of time, long after you free the BigInt, you must first create a copy so that it will not be freed when the BigInt is.

The standard usage of this is as follows:

    printf("bi = %s\n", BigIntBase10Rep(bi));

Where the variable <tt>bi</tt> is the BigInt of which to print.

## Notes

Negative numbers are currently supported.  Multiplication and additional are "fully functional".  Subtraction is pretty much perfect, but there might be some bugs.  As of a few builds ago, there were no leaks.  Now there might be a few.  I will check for leaks before the next commit.
