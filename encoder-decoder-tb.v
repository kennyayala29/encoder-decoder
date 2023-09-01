`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////// 
// Engineer: Kenneth Ayala
// 
// Create Date: 11/04/2022 11:16:10 AM
// Design Name: encoder/decoder testbench
// Module Name: tb_encoder_decoder
// Project Name: lab 1

// Description: test bench for encoder/decoder, links both encoder and decoder module
// in testbench. In this testbench there is an error reg where we can add where we 
// want the single bit error. So the decoder can correct it and output the correct data

//////////////////////////////////////////////////////////////////////////////////

module tb_encoder_decoder(
    );
    
    //encoder
    reg [3:0] data;
    wire [6:0] codeword;
    //decoder
    wire [6:0] error_codeword;
    wire [6:0] fixed_codeword;
    wire [3:0] decoded_data;
    //error bus
    reg [6:0] error; //will determine which bit will get error
    
    reg clk;
    reg reset;
    
    assign error_codeword = error ^ codeword; //interrupted code word with single bit error

    encoder encoder1 (.data(data),.codeword(codeword),.clk(clk),.reset(reset));
    decoder decoder1 (.data(decoded_data),.in(error_codeword),.clk(clk),.reset(reset),.fixed_codeword(fixed_codeword));



/////////////////////////////////////////////////////
//loop to create clock input
 always 
 begin 
clk = 1'b0; #10;
clk = 1'b1; #10;
 end
/////////////////////////////////////////////////////
/////////////////////////////////////////////////////

initial 
    begin 
    //begins with one reset
    reset =   1'b1;  data = 4'b0000; error = 7'b0000000; #50;
                                   
    reset =   1'b0;  data = 4'b0000; error = 7'b0000000; #100;
    reset =   1'b0;  data = 4'b0001; error = 7'b0000001; #100;
    reset =   1'b0;  data = 4'b0010; error = 7'b0000010; #100;
    reset =   1'b0;  data = 4'b0011; error = 7'b0000100; #100;
    reset =   1'b0;  data = 4'b1000; error = 7'b0001000; #100;
    reset =   1'b0;  data = 4'b1001; error = 7'b0010000; #100;
    reset =   1'b0;  data = 4'b1010; error = 7'b0100000; #100;
    reset =   1'b0;  data = 4'b1011; error = 7'b1000000; #100;  
    reset =   1'b0;  data = 4'b1111; error = 7'b0000001; #100;
    /////////////////////////////////////////////////////
    //reset enabled
    reset =   1'b1;  data = 4'b0000; #30;
    reset =   1'b1;  data = 4'b0001; #30;
    /////////////////////////////////////////////////////
    //back to reset disabled 
    reset =   1'b0;  data = 4'b0000; #30;

   end
   endmodule
