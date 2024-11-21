#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#define FIFO_NAME1 "comm_pipe1" // Name for the first FIFO pipe (reader-to-writer communication)
#define FIFO_NAME2 "comm_pipe2" // Name for the second FIFO pipe (writer-to-reader communication)

int main() {
    char s[300], vowel[20], send[300];  // Buffers for input sentence, vowels, and the result message
    int num, fd1, fd2, sig, k = 0, i, wordcnt = 0, charcnt = 0, linecnt = 0;  // Counters and file descriptors

    // Create two FIFO special files (named pipes)
    mknod(FIFO_NAME1, S_IFIFO | 0666, 0);  // FIFO for reading from the reader process
    mknod(FIFO_NAME2, S_IFIFO | 0666, 0);  // FIFO for writing to the reader process

    // Wait for the reader process to connect
    printf("FIFO 2nd side connected, waiting for the other process to connect to the FIFO pipe...\n");

    // Open the FIFOs: fd1 for reading (from reader), fd2 for writing (to reader)
    fd1 = open(FIFO_NAME1, O_RDONLY); 
    fd2 = open(FIFO_NAME2, O_WRONLY);

    if (fd1 == -1 || fd2 == -1) {  // Check for errors in opening the FIFOs
        perror("Error opening FIFOs");
        exit(1);  // Exit if error occurs
    }

    // Successfully established connection
    printf("Established connection\n");

    // Read data from FIFO1
    if ((num = read(fd1, s, 300)) == -1) {
        perror("Error reading from FIFO1");
    } 
    else {
        s[num] = '\0';  // Null-terminate the received string
        printf("Read %d bytes: \"%s\"\n", num, s);

        // Initialize counters
        k = 0; wordcnt = 0; charcnt = 0; linecnt = 0;

        // Process each character in the received string
        for(i = 0; i < num; i++) {
            // Count lines based on periods (.)
            if(s[i] == '.') {
                linecnt++; 
            }

            // Count words (based on spaces, periods, or null characters)
            if (s[i] == ' ' || s[i] == '.' || s[i] == '\0') {
                if (i > 0 && s[i - 1] != ' ' && s[i - 1] != '\n') {
                    wordcnt++; 
                }
            } 
            else {  // Count characters and vowels
                charcnt++;  
                if (s[i] == 'a' || s[i] == 'e' || s[i] == 'i' || s[i] == 'o' || s[i] == 'u') {
                    vowel[k++] = s[i];  // Store vowels in the 'vowel' array
                }
            }
        }

        // If the last character is not space or newline, it's part of a word
        if (num > 0 && s[num - 1] != ' ' && s[num - 1] != '\n') {
            wordcnt++;
        }

        vowel[k] = '\0';  // Null-terminate the vowel string

        // Prepare the result string with word count, vowel count, character count, and line count
        sprintf(send, "For the given sentence: Word count is %d\nVowel count is %d\nCharacter count is %d\nLines are %d\n", wordcnt, k, charcnt, linecnt);

        // Write the results to FIFO2
        if ((sig = write(fd2, send, strlen(send))) == -1) {
            perror("Error writing to FIFO2");
        } 
        else {
            printf("\nWritten successfully to FIFO2\n");
        }
    }

    // Close the FIFOs
    close(fd1);
    close(fd2);

    return 0;
}


#writer

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>

#define FIFO_NAME1 "comm_pipe1"  // Name for the first FIFO pipe (reader-to-writer communication)
#define FIFO_NAME2 "comm_pipe2"  // Name for the second FIFO pipe (writer-to-reader communication)

int main() {
    char input[300], received[300];  // Buffers for user input and received message
    int fd1, fd2, sig, num;

    // Create two FIFO special files (named pipes)
    mknod(FIFO_NAME1, S_IFIFO | 0666, 0);  // FIFO for writing to the writer process
    mknod(FIFO_NAME2, S_IFIFO | 0666, 0);  // FIFO for reading from the writer process

    // Wait for the writer process to connect
    printf("FIFO 1st side connected, waiting for the other process to connect to the FIFO pipes...\n");

    // Open the FIFOs: fd1 for writing (to writer), fd2 for reading (from writer)
    fd1 = open(FIFO_NAME1, O_WRONLY);    
    fd2 = open(FIFO_NAME2, O_RDONLY);

    if (fd1 == -1 || fd2 == -1) {  // Check for errors in opening the FIFOs
        perror("Error opening FIFOs");
        exit(1);  // Exit if error occurs
    }

    // Successfully established connection
    printf("Established connection\n");

    // Get input from the user (string to send to the writer)
    printf("Enter a string to send to the reader process: ");
    fgets(input, sizeof(input), stdin);  // Read user input
    input[strlen(input) - 1] = '\0';  // Remove the newline character at the end

    // Write the input to FIFO1
    if ((sig = write(fd1, input, strlen(input))) == -1) {
        perror("Error writing to FIFO1");
    } 
    else {
        printf("\nSent data to FIFO1\n");
    }

    // Read the results from FIFO2 (from the writer process)
    if ((num = read(fd2, received, 300)) == -1) {
        perror("Error reading from FIFO2");
    } else {
        received[num] = '\0';  // Null-terminate the received string
        printf("\nReceived the following from the reader process:\n%s\n", received);  // Display results
    }

    // Close the FIFOs
    close(fd1);
    close(fd2);

    return 0;
}


    return 0;
}
