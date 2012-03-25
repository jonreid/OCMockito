// Include this source in your primary target (not your test bundle).
// http://www.infinite-loop.dk/blog/2012/02/code-coverage-and-fopen-unix2003-problems/

#include <stdio.h>

FILE *fopen$UNIX2003( const char *filename, const char *mode );
size_t fwrite$UNIX2003( const void *a, size_t b, size_t c, FILE *d );


FILE *fopen$UNIX2003( const char *filename, const char *mode )
{
    return fopen(filename, mode);
}

size_t fwrite$UNIX2003( const void *a, size_t b, size_t c, FILE *d )
{
    return fwrite(a, b, c, d);
}
