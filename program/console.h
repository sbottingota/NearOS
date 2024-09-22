#ifndef _COMMAND_H
#define _COMMAND_H

#include <stdbool.h>

#define MAX_COMMANDS 32
#define MAX_ARGS 16
#define COMMAND_NAME_LENGTH 16
#define COMMAND_LENGTH  64
#define COMMAND_DESCRIPTION_LENGTH 64

#define PROMPT "$ "

typedef void (*command_fun)(int, char **); // argc, argv

struct command_entry {
    char name[COMMAND_NAME_LENGTH];
    char description[COMMAND_DESCRIPTION_LENGTH];
    command_fun command;
};

bool register_command(char *, char *, command_fun); // returns whether function succedes
command_fun get_command(char *);
void evaluate_command(void);

bool command_entry_eq(struct command_entry, struct command_entry);

void command_initialize(void); // initializes default commands and other stuff

#endif

