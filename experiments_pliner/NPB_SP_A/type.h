#ifndef __TYPE_H__
#define __TYPE_H__

typedef bool logical; //typedef enum { false, true } logical;
typedef struct { 
  double real;
  double imag;
} dcomplex;


#define min(x,y)    ((x) < (y) ? (x) : (y))
#define max(x,y)    ((x) > (y) ? (x) : (y))

#ifndef PRINT_RESULTS
#define PRINT_RESULTS 0
#endif

#if !PRINT_RESULTS
#define printf(...)
#endif

#endif //__TYPE_H__
