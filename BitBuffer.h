/*
 *  BitBuffer.h
 *  Giraffe
 *
 *  Created by Alex Nichol on 1/21/11.
 *  Copyright 2011 __MyCompanyName__. All rights reserved.
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <strings.h>
#include <sys/types.h>

#define kByteAdd 512
#define kReverseEndian 0

#ifndef UInt8
typedef unsigned char UInt8;
#endif

#ifndef UInt32
typedef unsigned int UInt32;
#endif

#ifndef Byte
typedef unsigned char Byte;
#endif

struct _BitBuffer {
	UInt8 * bytes;
	int byteCount;
	int bitCount;
};

typedef struct _BitBuffer *BitBuffer;

BitBuffer BitBufferNew (UInt32 initialBytes);
BitBuffer BitBufferNewBytes (Byte * bytes, UInt32 length);
void BitBufferAddBit (BitBuffer bb, UInt8 isOn);
void BitBufferSetBit (BitBuffer bb, UInt8 isOn, int index);
UInt8 BitBufferGetBit (BitBuffer bb, UInt32 _bitIndex);
const Byte * BitBufferGetBytes (BitBuffer bb, UInt32 * length);
void BitBufferFree (BitBuffer bb, UInt8 deleteBuffer);
