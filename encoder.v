`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
/* 
 Engineer: Anthony Ruiz
 
 Create Date: 11/03/2022 10:33:30 AM
 Design Name: 
 Module Name: encoder
 Project Name: lab 1

Description: this is the encoder module for the encoder/decoder, it will encode the 
             input (4bit bus) and then output the code word (7bit bus).
             There is also a clock input and a asyncronous reset      


p1 p2 d0 p3 d1 d2 d3

p1 = d3 XOR d2 XOR d0
p2 = d3 XOR d1 XOR d0
p3 = d2 XOR d1 XOR d0
*/
//////////////////////////////////////////////////////////////////////////////////


module encoder(
    input [3:0] data, //4 bit bus
    output [6:0] codeword, //7 bit bus 
    input clk,
    input reset
    );
    
    wire p1, p2, p3;
    reg [6:0] tmpOut;
    
    assign p1 = data[3] ^ data[2] ^ data[0];
    assign p2 = data[3] ^ data[1] ^ data[0];
    assign p3 = data[2] ^ data[1] ^ data[0];
    
    
    
    //XOR(p1, data[3],data[2],data[0]);
    //XOR(p2, data[3],data[1],data[0]);   
    //XOR(p3, data[2],data[1],data[0]);
    
    
      always @(posedge clk or posedge reset)
        begin 
        if (reset)
              tmpOut = 7'b0000000;
              //codeword would become 0000000 if reset = 1
        else 
              //if reset = 0
           tmpOut = {p1,p2,data[3],p3,data[2],data[1],data[0]};
              //creates a sting of data -->  p1 p2 d3 p3 d2 d1 d0
        end  
        assign codeword = tmpOut;
Endmodule
