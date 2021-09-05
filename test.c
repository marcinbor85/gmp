#include "gmp.h"

#define MAX_POINTS 4

typedef struct {
        int x;
        int y;
} point_t;

GMP_DECLARE(point, sizeof(point_t), MAX_POINTS);

int main(int argc, char *argv[])
{
        GMP_IMPORT(point);

        GMP_INIT(point);

        point_t *s = GMP_MALLOC(point);

        s->x = 0;
        s->x = 1;

        GMP_FREE(point, s);

        return 0;
}
