# Infinteger

Infinteger is a C library that can be used to achieve infinitely large integers.  Since it is a work in progress, the code might still have a few bugs to work out.  The major functionality of the library is done, as you can see by building the project and running it.  

Here is my original to-do list for Infinteger:

1. Addition
2. Multiplication
3. Subtraction
4. Division
5. Negative numbers (or flags, rather).
6. Comparative operators (e.g >, <, =)
7. Modulus
8. An Objective-C wrapper

The Objective-C wrapper is done (for the most part), and is included in the project.  The next half of this readme file will be about the C library, then I will have a section about using the Objective-C library.

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

## Notes for the C library

Addition, subtraction, multiplication, and division are all complete.  The basic operators are present, but the more complex ones such as <= and >= are not there.  The only way to check if a number is negative is to get the base 10 string for it, or check the flag using <tt>BigIntFlagIsSet</tt>.  There are no known leaks, so if you find one, please inform me.

## The Objective-C wrapper

Infinteger now comes with an easy-to-use Objective-C wrapper that utilizes the <tt>BigIntRef</tt> object.  This library works the same way as the C library.  A number is stored as an immutable object, the class of which being <tt>ANInteger</tt>.  An <tt>ANInteger</tt> object can perform operations, check operators, using Apple's <tt>NSString</tt> class.  An <tt>ANInteger</tt> object can be initialized as follows:

    ANInteger * is = [ANInteger integerWithString:@"123"];
    ANInteger * ii = [ANInteger integerWithInt:123];
    ANInteger * ic = [[ANInteger alloc] initWithInteger:is];
    ANInteger * ir = [[ANInteger alloc] initWithBigIntRef:bi];

The last two methods allocated an object without autoreleasing it, meaning that you will have to release it yourself.  The first two methods autorelease the returned object, meaning that you don't have to worry about releasing.

### String values

Just like the C library, you can get a string from an <tt>ANInteger</tt> object.  Unlike the C library, this is returned as an <tt>NSString</tt> object, instead of a null-terminated character array.  Obtain an <tt>NSString</tt> from an <tt>ANInteger</tt> as follows:

    NSString * string = [is stringValue];

In that example, I am getting the string value of the ANInteger object <tt>is</tt>, and putting it into my <tt>string</tt> variable.  The return value of this function is autoreleased, so do not bother releasing it.

### Mathematical operations

Your <tt>ANInteger</tt> objects can run operations on each other.  Each operation run between two integers returns a fresh integer, which will be autoreleased.  Here is an example of subtraction:

    ANInteger * quotient = [num1 divideBy:num2];

This is basically stating that <tt>quotient = num1 / num2</tt>.  There are four different operation functions on <tt>ANInteger</tt> which are declared as follows:

    - (ANInteger *)multiplyBy:(ANInteger *)i1;
    - (ANInteger *)addBy:(ANInteger *)i1;
    - (ANInteger *)subtractBy:(ANInteger *)i1;
    - (ANInteger *)divideBy:(ANInteger *)i1;

### Comparing integers

It is easy to compare two <tt>ANInteger</tt> objects, using one of three functions.  You can check if two <tt>ANInteger</tt> objects are equal, using <tt>isEqual:</tt>.  You can check if one <tt>ANInteger</tt> is larger than another one with <tt>isGreaterThan:</tt>.  The opposite goes for <tt>isLessThan:</tt>.  These functions are used as follows:

    BOOL b = [i1 isEqual:i2];
    BOOL b = [i1 isGreaterThan:i2];
    BOOL b = [i1 isLessThan:i2];

In the third example, you are checking if <tt>i1</tt> is less than <tt>i2</tt>.  This order is the same for the other two examples.