`timescale 1ns / 1ps

//Dual (n+1)-bit gray counter



module gray_counter #(parameter n=4)(
    input clk,
    input rst_n,    //asynchronous active low reset
    input inc,
    input full_empty,     // !full or !empty
    output [n-1:0] bptr,
    output reg [n:0] gptr, galmost_ptr
);

    reg [n:0] bin;
    wire [n:0] bnext;
    wire [n:0] gnext;
    wire [n:0] balmost;
    wire [n:0] galmost;

    always @(posedge clk, negedge rst_n) begin
        if(!rst_n) begin
            bin <= {n{1'b0}};
            gptr <= {n{1'b0}};
        end
        else begin
            bin <= bnext;
            gptr <= gnext;
        end
    end

    assign bnext = bin + (inc & ~full_empty);

    assign gnext = (bnext>>1) ^ bnext;

    assign bptr = bin[n-1:0];



    assign balmost = bnext + 1'd1;

    assign galmost = (balmost>>1) ^ balmost;

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) galmost_ptr <= {n{1'b0}};
        else galmost_ptr <= galmost;
    end

endmodule
