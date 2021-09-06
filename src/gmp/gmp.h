/*
MIT License

Copyright (c) 2021 Marcin Borowicz <marcinbor85@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/

#ifndef GMP_H
#define GMP_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stddef.h>

typedef size_t gmp_word_t;

#define GMP_DECLARE(name, blk_size, blk_count)\
static gmp_word_t _gmp_buffer_##name[((gmp_word_t)(blk_size) * (gmp_word_t)(blk_count)) / sizeof(gmp_word_t)];\
static const struct gmp_descriptor _gmp_descriptor_##name = {\
        .buffer = _gmp_buffer_##name,\
        .block_size = (gmp_word_t)(blk_size),\
        .block_count = (gmp_word_t)(blk_count),\
};\
struct gmp _gmp_##name = {\
        .desc = &_gmp_descriptor_##name,\
        .first = _gmp_buffer_##name\
};

struct gmp_descriptor {
        gmp_word_t *buffer;
        gmp_word_t block_size;
        gmp_word_t block_count;
};

struct gmp {
        struct gmp_descriptor const *desc;
        void *first;
};

#define GMP_IMPORT(name) extern struct gmp _gmp_##name;

#define GMP_INIT(name) gmp_init(&_gmp_##name);
#define GMP_MALLOC(name) gmp_malloc(&_gmp_##name);
#define GMP_FREE(name, blk) gmp_free(&_gmp_##name, blk);

void gmp_init(struct gmp *self);
void* gmp_malloc(struct gmp *self);
void gmp_free(struct gmp *self, void *block);

#ifdef __cplusplus
}
#endif

#endif /* GMP_H */
