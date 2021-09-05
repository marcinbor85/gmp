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

#include "gmp.h"

void gmp_init(struct gmp *self)
{
        gmp_word_t index = 0;
        gmp_word_t last_index = self->desc->block_count - 1;
        
        while (index < self->desc->block_count) {
                gmp_word_t offset = index * self->desc->block_size / sizeof(gmp_word_t);
                gmp_word_t *block = &(((gmp_word_t*)self->desc->buffer)[offset]);
                *block = (index == last_index) ? (gmp_word_t)NULL : (gmp_word_t)block + self->desc->block_size;
                index++;
        }
        self->first = self->desc->buffer;
}

void* gmp_malloc(struct gmp *self)
{
        if (self->first == NULL)
                return NULL;
        void *block = self->first;
        self->first = (void*)(*(gmp_word_t*)block);
        return block;
}

void gmp_free(struct gmp *self, void *block)
{
        gmp_word_t *next = block;
        *next = (gmp_word_t)self->first;
        self->first = next;
}
