#include "tty.h"

#include "vga.h"
#include "kbd.h"
#include "util.h"

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
uint8_t terminal_error_color;
uint16_t *terminal_buffer;

void enable_cursor(uint8_t cursor_start, uint8_t cursor_end) {
	out_port_b(0x3D4, 0x0A);
	out_port_b(0x3D5, (in_port_b(0x3D5) & 0xC0) | cursor_start);

	out_port_b(0x3D4, 0x0B);
	out_port_b(0x3D5, (in_port_b(0x3D5) & 0xE0) | cursor_end);
}

void disable_cursor(void) {
	out_port_b(0x3D4, 0x0A);
	out_port_b(0x3D5, 0x20);
}

void update_cursor(int x, int y) {
	uint16_t pos = y * VGA_WIDTH + x;

	out_port_b(0x3D4, 0x0F);
	out_port_b(0x3D5, (uint8_t) (pos & 0xFF));
	out_port_b(0x3D4, 0x0E);
	out_port_b(0x3D5, (uint8_t) ((pos >> 8) & 0xFF));
}
void terminal_initialize(void) {
    terminal_row = 0;
    terminal_column = 0;
    terminal_color = vga_entry_color(VGA_COLOR_BLACK, VGA_COLOR_WHITE);
    terminal_error_color = vga_entry_color(VGA_COLOR_RED, VGA_COLOR_WHITE);
    terminal_buffer = (uint16_t *) 0xB8000;
    
    enable_cursor(0, 15);

    for (size_t y = 0; y < VGA_HEIGHT; ++y) {
        for (size_t x = 0; x < VGA_WIDTH; ++x) {
            const size_t index = y * VGA_WIDTH + x;
            terminal_buffer[index] = vga_entry(' ', terminal_color);
        }
    }
}

void terminal_setcolor(uint8_t color) {
    terminal_color = color;
}

void terminal_putentryat(char c, uint8_t color, size_t x, size_t y)  {
    const size_t index = y * VGA_WIDTH + x;
    terminal_buffer[index] = vga_entry(c, color);
}

void terminal_scrolltext(void) {
    for (size_t i = VGA_WIDTH; i < VGA_WIDTH*VGA_HEIGHT; ++i) {
        terminal_buffer[i - VGA_WIDTH] = terminal_buffer[i];
    }
    for (size_t i = 0; i < VGA_WIDTH; ++i) {
        terminal_buffer[VGA_WIDTH * (VGA_HEIGHT - 1) + i] = vga_entry(' ', terminal_color);
    }
}

void terminal_putchar(char c) {
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
            if (terminal_column == 0 && terminal_row == 0) break;
            if (terminal_column == 0) {
                --terminal_row;
                terminal_column = VGA_WIDTH;
            }

            --terminal_column;
            terminal_buffer[terminal_row * VGA_WIDTH + terminal_column] = vga_entry(' ', terminal_color);
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

    update_cursor(terminal_column, terminal_row);
}

int terminal_getchar(void) {
    char c = '\0';
    void listener(void) {
        if (get_current_press() == 0 && is_printable(get_current_char())) {
            c = get_current_char();
        }
    }

    add_listener(listener);

    while (c == '\0') {
        __asm__("nop");
    }

    remove_listener(listener);

    return c;
}

void terminal_write(const char *data, size_t size) {
    for (size_t i = 0; i < size; ++i) {
        terminal_putchar(data[i]);
    }
}

void terminal_error(const char *data, size_t size) {
    uint8_t prev_color = terminal_color;    
    terminal_color = terminal_error_color;
    terminal_write(data, size);
    terminal_color = prev_color;
}

void terminal_write_string(const char *str) {
    for (const char *c = str; *c != '\0'; ++c) {
        terminal_putchar(*c);
    }
}
void terminal_error_string(const char *str) {
    uint8_t prev_color = terminal_color;    
    terminal_color = terminal_error_color;
    terminal_write_string(str);
    terminal_color = prev_color;
}

