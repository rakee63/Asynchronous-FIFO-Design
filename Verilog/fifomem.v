`timescale 1ns / 1ps

//fifo memory




module fifomem #(parameter n=4,
                 parameter DATA=8,
                 parameter DEPTH=16)(
    input clk,
    input wclken,
    input [n-1:0] waddr,
    input [n-1:0] raddr,
    input [DATA-1:0] wdata,
    output [DATA-1:0] rdata
);

    reg [DATA-1:0] MEM [0:DEPTH-1];

    assign rdata = MEM[raddr];

    always @(posedge clk) begin
        if(wclken) MEM[waddr] <= wdata;
        else MEM[waddr] <= MEM[waddr];
    end


endmodule
