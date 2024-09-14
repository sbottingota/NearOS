#include "tty.h"

#include "vga.h"

// #include <string.h>

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

static const size_t VGA_WIDTH = 80;
static const size_t VGA_HEIGHT = 25;

static const size_t TAB_SIZE = 4;
static const size_t VTAB_SIZE = 1;

size_t terminal_row;
size_t terminal_column;
uint8_t terminal_color;
uint16_t *terminal_buffer;

void terminal_initialize(void)
{
    terminal_row = 0;
    terminal_column = 0;
    terminal_color = vga_entry_color(VGA_COLOR_BLACK, VGA_COLOR_WHITE);
    terminal_buffer = (uint16_t *) 0xB8000;

    for (size_t y = 0; y < VGA_HEIGHT; ++y) {
        for (size_t x = 0; x < VGA_WIDTH; ++x) {
            const size_t index = y * VGA_WIDTH + x;
            terminal_buffer[index] = vga_entry(' ', terminal_color);
        }
    }
}

void terminal_setcolor(uint8_t color)
{
    terminal_color = color;
}

void terminal_putentryat(char c, uint8_t color, size_t x, size_t y) 
{
    const size_t index = y * VGA_WIDTH + x;
    terminal_buffer[index] = vga_entry(c, color);
}

void terminal_scrolltext(void)
{
    for (size_t i = VGA_WIDTH; i < VGA_WIDTH*VGA_HEIGHT; ++i) {
        terminal_buffer[i - VGA_WIDTH] = terminal_buffer[i];
    }
    for (size_t i = 0; i < VGA_WIDTH; ++i) {
        terminal_buffer[VGA_WIDTH * (VGA_HEIGHT - 1) + i] = vga_entry(' ', terminal_color);
    }
}

void terminal_putchar(char c)
{
    switch (c) {
        case '\n':
            terminal_column = 0;
            ++terminal_row;
            break;

        case '\t':
            terminal_column += TAB_SIZE;
            break;

        case '\v':
            terminal_row += VTAB_SIZE;
            break;

        case '\r':
            terminal_column = 0;
            break;

        case '\b':
            if (terminal_column > 0) {
                --terminal_column;
            }
            break;

        default:
            terminal_putentryat(c, terminal_color, terminal_column, terminal_row);
            ++terminal_column;
            break;
    }

    if (terminal_column == VGA_WIDTH) {
        terminal_column = 0;
        ++terminal_row;
    }
    if (terminal_row == VGA_HEIGHT) {
        --terminal_row;
        terminal_scrolltext();
    }
}

void terminal_write(const char *data, size_t size)
{
    for (size_t i = 0; i < size; ++i) {
        terminal_putchar(data[i]);
    }
}

void terminal_writestring(const char *data)
{
    terminal_write(data, strlen(data));
}
