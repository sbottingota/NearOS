#include "console.h"

#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <time.h>

struct command_entry commands[MAX_COMMANDS];
size_t n_registered_commands = 0;

int program_counter = 0;
struct command_block program[MAX_PROGRAM_LENGTH];

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

bool store_command_block(int index, command_fun command, int argc, char **argv) {
    program[index].command = command;
    program[index].argc = argc;
    for (int i = 0; i < argc; ++i) {
        strcpy(program[index].argv[i], argv[i]);
    }
}

void evaluate_command(void) {
    char buf[COMMAND_LENGTH];
    printf("%s", PROMPT);
    gets(buf);

    if (strcmp(buf, "") == 0) return;

    // split the string in two
    int argc = 1;
    char *argv[MAX_ARGS] = {buf};
    for (char *c = buf; *c != '\0' && argc < MAX_ARGS; ++c) {
        if (*c == ' ') {
            *c = '\0';
            ++c;

            argv[argc] = c;
            ++argc;
        }
    }

    bool is_immediately_run = argv[0][0] < '0' || argv[0][0] > '9'; // if command does not begin with 1-9
    if (is_immediately_run) {
        command_fun command = get_command(argv[0]);
        if (command == NULL) {
            printf("Unknown command '%s'. Try 'help'.\n", argv[0]);
            return;
        }

        command(argc, argv);
    } else {
        int index = atoi(argv[0]);
        command_fun command = get_command(argv[1]);
        if (command == NULL) {
            printf("Unknown command '%s'. Try 'help'.\n", argv[1]);
            return;
        }

        store_command_block(index, command, argc - 1, argv + 1);
    }
}

void help() {
    printf("List of all known commands:\n");
    
    for (int i = 0; i < n_registered_commands; ++i) {
        printf("\n%s: %s\n", commands[i].name, commands[i].description);
    }
}

void echo(int argc, char **argv) {
    printf("\t%d\n", argc);
    for (int i = 1; i < argc; ++i) {
        printf("%s ", argv[i]);
    }
    printf("\n");
}

void run() {
    program_counter = 0;
    while (program_counter < MAX_PROGRAM_LENGTH) {
        struct command_block command = program[program_counter];
        ++program_counter;
        if (command.command == NULL) continue;
        command.command(command.argc, command.argv);
    }
}

void print_time() {
    printf("%d\n", clock());
}

void console_initialize(void) {
    for (int i = 0; i < MAX_PROGRAM_LENGTH; ++i) {
        program[i].command = NULL;
    }

    // memset(commands, 0, sizeof commands);
    register_command("help", "Prints this menu", help);
    register_command("echo", "Prints it's arguments", echo);
    register_command("time", "Prints the time since startup, in ms", print_time);
    register_command("run", "Runs the stored program", run);
}

