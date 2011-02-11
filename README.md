# Infinteger

This library is currently being developed, and therefore is not yet fully functional.  The features it will include are:

1. Addition
2. Multiplication
3. Subtraction
4. Division
5. Negative numbers (or flags, rather).
6. Comparative operators (e.g >, <, =)

## The Basics

There is a structure, called BigIntRef (which is actually a reference to a structure), that represents a BigInt object.  To create one, you can use one of three functions:
    BigIntRef bi = BigIntNew(23);
    BigIntRef bi = BigIntCreateDecimal("15");
	BigIntRef bi = BigIntCreateCopy(bi1, 0);

I suggest using the second one, BigIntCreateDecimal, since it allows you to pass a string that can be of any length.  This means that there is no aspect in which you are limited by the size of a C-style integer.

## Operations

Currently, only multiplication and addition are currently supported.  Subtraction is in a very beta phase, where it only works if the first number is larger than the second.  Soon negative numbers with flourish the library, but for now they are unsupported.

Here is the code for a simple BigInt addition operation:

    BigIntRef people = BigIntAdd(females, males);

Note that every BigInt returned by a function is retained exactly once, and therefore you must call BigIntRelease() on the people variable in the previous example.  Likewise, multiplication is very similar:

    BigIntRef area = BigIntMultiply(height, width);

Currently, multiplication does not support the properties of negatives, but that does not much matter since negative numbers are not supported at all.

## Notes

Negative numbers will be the next thing that are added, since they are so important.  With them will come a full subtraction function.  Adding negative numbers will involve changing around pretty much every function, making them more complicated.  This means that it might take some time to do, so be patient!
