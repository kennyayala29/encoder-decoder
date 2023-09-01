`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/* 
 Engineer: Kenneth Ayala
 
 Create Date: 11/04/2022 10:33:30 AM
 Design Name: module for decoder
 Module Name: decoder
 Project Name: lab 1

Description: this is the decoder, it will correct any bit error it detects (can only correct single-bit errors).
It recalculates the parity bits, determine which bit to flip to correct a single bit error. Will decode the 7-bit 
codeword and extract the 4-bit data. Use 7 bit bus as input(codeword), clock input and asynchronous reset input and
4-bit bus output(data).

*/
//////////////////////////////////////////////////////////////////////////////////


module decoder(
    input [6:0] in, //7 bit bus
    output [3:0] data, //4 bit bus
    output [6:0] corrected_In, // fixes one bit error and returns new corrected value
    input clk,
    input reset
    );
    reg [6:0] n;
    reg [6:0] r;
    reg [2:0] c;
    reg [3:0] tmpOut;
    
    always @(posedge clk or posedge reset)
        begin 
     r = in;
     c[0] = in[6]^in[4]^in[2]^in[0]; //p1
     c[1] = in[5]^in[4]^in[1]^in[0]; //p2
     c[2] = in[3]^in[2]^in[1]^in[0]; //p3

    if (reset)
    tmpOut = 3'b000;
     
    else if (c == 3'b000) 
    begin
        tmpOut[0] = r[0];
        tmpOut[1] = r[1];
        tmpOut[2] = r[2];
        tmpOut[3] = r[4];
    end
    else
    begin 
    case(c)
        3'b001: r[6]=~r[6];
        3'b010: r[5]=~r[5];
        3'b011: r[4]=~r[4];
        3'b100: r[3]=~r[3];
        3'b101: r[2]=~r[2];
        3'b110: r[1]=~r[1];
        3'b111: r[0]=~r[0];
       
    endcase 
    tmpOut[0]=r[0];
    tmpOut[1]=r[1];
    tmpOut[2]=r[2];
    tmpOut[3]=r[4];
    end
    end
    assign corrected_In = r;
    assign data = tmpOut;
    
    
endmodule
