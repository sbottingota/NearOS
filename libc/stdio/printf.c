#include <limits.h>
#include <stdbool.h>
#include <stdarg.h>

#include "stdio.h"
#include "../string/string.h"

#include "tty.h"

void printf(const char *restrict format, ...) {
	va_list parameters;
	va_start(parameters, format);

	int written = 0;

	while (*format != '\0') {
		if (format[0] != '%' || format[1] == '%') {
			if (format[0] == '%') {
				format++;
            }

			size_t amount = 1;
			while (format[amount] && format[amount] != '%') {
				amount++;
            }

			terminal_write(format, amount);

			format += amount;
			written += amount;
			continue;
		}

		const char *format_begun_at = ++format;

		if (*format == 'c') {
			++format;
			char c = (char) va_arg(parameters, int /* char promotes to int */);
			terminal_write(&c, sizeof(c));

			++written;
		} else if (*format == 's') {
			++format;
			const char *str = va_arg(parameters, const char *);
			size_t len = strlen(str);
			terminal_write(str, len);
			written += len;
		} else {
			format = format_begun_at;
			size_t len = strlen(format);
			terminal_write(format, len);

			written += len;
			format += len;
		}
	}

	va_end(parameters);
}

