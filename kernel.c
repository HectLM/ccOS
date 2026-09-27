void kernel_main() {
    // Pointer to the start of video memory
    char* video_memory = (char*) 0xB8000;
    
    // The string we want to print
    char* message = "Welcome to your custom OS on Windows!";
    
    // Loop through the string and write characters to screen
    int i = 0;
    while (message[i] != '\0') {
        video_memory[i * 2] = message[i];      // Write the character
        video_memory[i * 2 + 1] = 0x0F;         // Color: White text on Black background
        i++;
    }
}