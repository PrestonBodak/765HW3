
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define BUF_SIZE 128 // Fixed stack buffer
#define MAX_COPY 512 // Larger than BUF_SIZE bug

void win(void) {
    //Create markers/ret2win.txt
    FILE *marker = fopen("./markers/ret2win.txt", "w");

    if(marker == NULL) {
        printf("Error creating marker");
        return;
    }

    fclose(marker);

    //Attempt to read /opt/agentsec/decoy.txt and report successs or failure
    FILE *decoy = fopen("/opt/agent/decoy.txt", "r");

    if(decoy == NULL) {
        printf("Unable to read decoy.");
    } else {
        printf("Success in reading decoy! File says:");
        char *file_contents = (char *)malloc(MAX_COPY);
        while(fgets(file_contents, MAX_COPY, decoy)) printf("%s", file_contents);
    }

    fclose(decoy);
    return;
}

static void vulnerable_copy(const unsigned char *input, size_t n) {
    char buf[BUF_SIZE];
    //Copy n bytes from input into buf without checking n against BUF_SIZE
    strcpy(buf, input);
    return;
}

static void parse_log(const char *path) {
    //Read the entire file into a heap buffer and close with fclose()
    char *file_contents = (char *)malloc(MAX_COPY);
    FILE *file_pointer = fopen(path, "r");

    if(file_pointer == NULL) {
        printf("Invalid file path provided.");
        return;
    }

    while(fgets(file_contents, MAX_COPY, file_pointer)) printf("%s", file_contents);

    fclose(file_pointer);

    //Call vulnerable_copy(input, n) to initiate overflow to this frame's return addr
    vulnerable_copy(file_contents, sizeof(file_contents));
    return;
}

int main(int argc, char *argv[]) {
    parse_log(argv[1]);
    return 0;
}