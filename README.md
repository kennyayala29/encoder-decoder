# encoder-decoder
Create an error correcting system, specifically Hamming(7,4) encoder and decoder in Verilog.

# Background

## Encoder:
The encoder generates the parity bits to complete the 7 bit output (codeword). The encoder takes in input data, a bus of 4 bits, and then adds the 3 extra parity bits by using xor gates to create the 7-bit codeword output. There is also a clock and reset 1 bit input. The module has an Asynchronous reset. As seen in the testbench picture below, the encoder does work. It works by getting data and creating extra bits by xoring certain bits of the data. Later the module concatenates the bits and data into an output called codeword.

## Decoder:
The decoder not only extracts the data of the codeword it corrects any single-bit error if detected. The decoder takes an input codeword of 7 bits and then outputs data of 4 bits. To detect if a single-bit error occurred it will need to locate which bit has the error. We did this by using reg C [2:0] to XOR with the codeword bits. C [0] = 0^2^4^6, C [1] = 0^1^4^5, and C [0] = 0^1^2^3 the C will detect which bit has the error. This is known as a parity check to locate the single-bit error. If C is equal to 000 there are no errors, and it will just extract the 4-bit data from the codeword. If the C value is 010 then the error is at bit 2 so using case statements depending on the C value, will flip the value using not gate. Then it will output a new codeword which is the fixed codeword and then output the 4-bit data based on the fixed codeword. The circuit works because in the testbench the waveform outputs the data that is expected from the codeword, and it corrects the bit if it has a one-bit error. 
