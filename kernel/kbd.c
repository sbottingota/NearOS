#include <stdint.h>
#include <stdbool.h>

#include "idt.h"
#include "util.h"
#include "tty.h"

#include "kbd.h"

enum unprintable {
    UNPRINTABLE_MAX = 0xFFFFFFFF,
    UNKNOWN = 0xFFFFFFFF,
    ESC = 0xFFFFFFFF - 1,
    CTRL = 0xFFFFFFFF - 2,
    LSHFT = 0xFFFFFFFF - 3,
    RSHFT = 0xFFFFFFFF - 4,
    ALT = 0xFFFFFFFF - 5,
    F1 = 0xFFFFFFFF - 6,
    F2 = 0xFFFFFFFF - 7,
    F3 = 0xFFFFFFFF - 8,
    F4 = 0xFFFFFFFF - 9,
    F5 = 0xFFFFFFFF - 10,
    F6 = 0xFFFFFFFF - 11,
    F7 = 0xFFFFFFFF - 12,
    F8 = 0xFFFFFFFF - 13,
    F9 = 0xFFFFFFFF - 14,
    F10 = 0xFFFFFFFF - 15,
    F11 = 0xFFFFFFFF - 16,
    F12 = 0xFFFFFFFF - 17,
    SCRLCK = 0xFFFFFFFF - 18,
    HOME = 0xFFFFFFFF - 19,
    UP = 0xFFFFFFFF - 20,
    LEFT = 0xFFFFFFFF - 21,
    RIGHT = 0xFFFFFFFF - 22,
    DOWN = 0xFFFFFFFF - 23,
    PGUP = 0xFFFFFFFF - 24,
    PGDOWN = 0xFFFFFFFF - 25,
    END = 0xFFFFFFFF - 26,
    INS = 0xFFFFFFFF - 27,
    DEL = 0xFFFFFFFF - 28,
    CAPS = 0xFFFFFFFF - 29,
    NONE = 0xFFFFFFFF - 30,
    ALTGR = 0xFFFFFFFF - 31,
    NUMLCK = 0xFFFFFFFF - 32,
    UNPRINTABLE_MIN = 0xFFFFFFFF - 32
};

const uint32_t lowercase[128] = {
UNKNOWN,ESC,'1','2','3','4','5','6','7','8',
'9','0','-','=','\b','\t','q','w','e','r',
't','y','u','i','o','p','[',']','\n',CTRL,
'a','s','d','f','g','h','j','k','l',';',
'\'','`',LSHFT,'\\','z','x','c','v','b','n','m',',',
'.','/',RSHFT,'*',ALT,' ',CAPS,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,NUMLCK,SCRLCK,HOME,UP,PGUP,'-',LEFT,UNKNOWN,RIGHT,
'+',END,DOWN,PGDOWN,INS,DEL,UNKNOWN,UNKNOWN,UNKNOWN,F11,F12,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,
UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,
UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,
UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN
};
const uint32_t uppercase[128] = {
    UNKNOWN,ESC,'!','@','#','$','%','^','&','*','(',')','_','+','\b','\t','Q','W','E','R',
'T','Y','U','I','O','P','{','}','\n',CTRL,'A','S','D','F','G','H','J','K','L',':','"','~',LSHFT,'|','Z','X','C',
'V','B','N','M','<','>','?',RSHFT,'*',ALT,' ',CAPS,F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,NUMLCK,SCRLCK,HOME,UP,PGUP,'-',
LEFT,UNKNOWN,RIGHT,'+',END,DOWN,PGDOWN,INS,DEL,UNKNOWN,UNKNOWN,UNKNOWN,F11,F12,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,
UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,
UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,
UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN,UNKNOWN
};

bool shifted = false;
bool caps_lock = false;

kbd_listener listeners[MAX_LISTENERS] = {0};

char get_current_scan_code(void) {
    return in_port_b(0x60) & 0x7F;
}

char get_current_press(void) {
    return in_port_b(0x60) & 0x80;
}

char get_current_char(void) {
    return parse_char(get_current_scan_code());
}

bool is_printable(char c) {
    return c < UNPRINTABLE_MIN || c > UNPRINTABLE_MAX;
}

char parse_char(char scan_code) {
    if ((shifted && !caps_lock) || (caps_lock && !shifted)) { // logical xor
        return uppercase[(int) scan_code];
    } else {
        return lowercase[(int) scan_code];
    }
}

void handle_shift_caps(void) {
    char scan_code = get_current_scan_code();
    char press = get_current_press();

    switch (scan_code) {
        case 42: // lshift
        case 54: // rshift
            shifted = press == 0; // if pressed, turn on, otherwise (if unpressed) turn off
            break;

        case 58: // caps lock
            if (press == 0) { // if pressed, toggle
                caps_lock = !caps_lock;
            }
            break;
    }
}

bool add_listener(kbd_listener listener) {
    for (int i = 0; i < MAX_LISTENERS; ++i) {
        if (listeners[i] == NULL) {
            listeners[i] = listener;
            return true;
        }
    }

    return false;
}

bool remove_listener(kbd_listener listener) {
    for (int i = 0; i < MAX_LISTENERS; ++i) {
        if (listeners[i] == listener) {
            listeners[i] = NULL;
            return true;
        }
    }

    return false;
}

void notify_listeners(struct interrupt_registers *regs) {
    for (int i = 0; i < MAX_LISTENERS; ++i) {
        if (listeners[i] != NULL) {
            listeners[i]();
        }
    }
}

void kbd_initialize(void) {
    irq_install_handler(1, notify_listeners);
    add_listener(handle_shift_caps);
}

