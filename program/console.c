#include "console.h"

#include <string.h>
#include <stdio.h>
#include <time.h>

struct command_entry commands[MAX_COMMANDS];
size_t n_registered_commands = 0;

inline bool command_entry_eq(struct command_entry a, struct command_entry b) {
    return a.name == b.name && a.description == b.description && a.command == b.command;
}

bool register_command(char *name, char *description, command_fun command) {
    if (n_registered_commands < MAX_COMMANDS) {
        strcpy(commands[n_registered_commands].name, name);
        strcpy(commands[n_registered_commands].description, description);
        commands[n_registered_commands].command = command;
        ++n_registered_commands;
        return true;
    }

    return false;
}

command_fun get_command(char *name) {
    for (int i = 0; i < n_registered_commands; ++i) {
        if (strcmp(name, commands[i].name) == 0) {
            return commands[i].command;
        }
    }

    return NULL;
}

void evaluate_command(void) {
    char buf[COMMAND_LENGTH];
    printf("%s", PROMPT);
    gets(buf);

    if (buf == "") return;

    // split the string in two
    int argc = 1;
    char *argv[MAX_ARGS] = {0};
    for (char *c = buf; *c != '\0' && argc < MAX_ARGS; ++c) {
        if (*c == ' ') {
            *c = '\0';
            ++c;

            argv[argc] = c;
            ++argc;
        }
    }

    command_fun command = get_command(buf);
    if (command == NULL) {
        printf("Unknown command '%s'. Try 'help'.\n", buf);
        return;
    }

    command(argc, argv);
}

void help() {
    printf("List of all known commands:\n");
    
    for (int i = 0; i < n_registered_commands; ++i) {
        printf("\n%s: %s\n", commands[i].name, commands[i].description);
    }
}

void echo(int argc, char **argv) {
    for (int i = 1; i < argc; ++i) {
        printf("%s ", argv[i]);
    }
    printf("\n");
}

void print_time() {
    printf("%d\n", clock());
}

void console_initialize(void) {
    // memset(commands, 0, sizeof commands);
    register_command("help", "Prints this menu", help);
    register_command("echo", "Prints it's arguments", echo);
    register_command("time", "Prints the time since startup, in ms", print_time);
}

