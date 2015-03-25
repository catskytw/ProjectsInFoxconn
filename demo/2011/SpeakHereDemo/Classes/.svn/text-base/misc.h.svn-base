//
//  misc.h
//  FcLameLib
//
//  Created by 廖 晨志 on 2011/7/6.
//  Copyright 2011年 foxconn. All rights reserved.
//
#ifdef HAVE_LIMITS_H
# include <limits.h>
#endif
    
#include "get_audio.h"

/* GLOBAL VARIABLES used by parse.c and main.c.  
 instantiated in parce.c.  ugly, ugly */
static sound_file_format input_format;
static int swapbytes=0;        /* force byte swapping   default=0 */
static int silent;
static int brhist;

static int mp3_delay;        /* for decoder only */
static int mp3_delay_set;    /* for decoder only */
static float update_interval; /* to use Frank's time status display */
static int disable_wav_header; /* for decoder only */
static mp3data_struct mp3input_data; /* used by MP3 */
static int print_clipping_info; /* print info whether waveform clips */
static int in_signed=-1;
static int in_unsigned;
static int in_bitwidth=16;
static int flush_write=0;

#ifndef PATH_MAX
#define PATH_MAX 1024
#endif
#define         Min(A, B)       ((A) < (B) ? (A) : (B))
#define         Max(A, B)       ((A) > (B) ? (A) : (B))


enum ByteOrder { ByteOrderLittleEndian, ByteOrderBigEndian };
static enum ByteOrder in_endian=ByteOrderLittleEndian;