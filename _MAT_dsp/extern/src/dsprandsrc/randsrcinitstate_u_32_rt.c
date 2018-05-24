/*
 *  randsrcinitstate_u_32_rt.c
 *  DSP Random Source Run-Time Library Helper Function
 *
 *  Copyright 1995-2013 The MathWorks, Inc.
 */

#if (!defined(INTEGER_CODE) || !INTEGER_CODE)

#ifdef MW_DSP_RT
#include "src/dsprandsrc64bit_rt.h"
#else
#include "dsprandsrc64bit_rt.h"
#endif
#include <math.h>

/* Assumed lengths:
 *  seed:   nChans
 *  state:  35*nChans
 */

LIBMW_SRC_API void MWDSP_RandSrcInitState_U_32(const uint32_T *seed,  /* seed value vector */
                                 real32_T       *state, /* state vectors */
                                 int_T          nChans) /* number of channels */
{
    uint32_T jzero = 0x80000000;
    uint32_T j;
    int_T k,n;
    real32_T d;

    while (nChans--) {
        /*
         * Generate 32 floating point values, one bit at a time,
         * from 20-th bit of random shift register sequence.
         */
        /* need init seed to be != 0 */
        j = *seed ? *seed : jzero;
        k = 32;
        while (k--) {
            d = 0.0F;
            n = 24;
            while (n--) {
                j ^= (j<<13); j ^= (j>>17); j ^= (j<<5);
                d = d + d + (real32_T) ((j >> 19) & 1);
            }
            *state++ = ldexpf(d,-24);
        }
        /* ulb = 0 */
        *state++ = 0.0F;
        /* i = 0 */
        *state++ = 0.0F;
        /* reset j to initial seed */
        j = (*seed ? *seed : jzero );
        *state++ = (real32_T)j;
        seed++;
    }
}

#endif /* !INTEGER_CODE */

/* [EOF] randsrcinitstate_u_rt.c */