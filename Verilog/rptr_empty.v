`timescale 1ns / 1ps

// rptr (read address) and empty (fifo empty signal)




module rptr_empty #(parameter n=4)(
    input clk,
    input rrst_n,
    input rinc,
    input aempty_n, aalmost_empty_n,
    output [n:0] r_gptr, r_galmost_ptr,
    output [n-1:0] r_bptr,
    output reg rempty, ralmost_empty
);

    reg rempty1, ralmost_empty1;

    gray_counter #(.n(n)) read_counter (
        // inputs
        .clk(clk),
        .rst_n(rrst_n),
        .inc(rinc),
        .full_empty(rempty),
        
        // outputs
        .bptr(r_bptr),
        .gptr(r_gptr),
        .galmost_ptr(r_galmost_ptr)
    );

    always @(posedge clk, negedge aempty_n) begin
        if(~aempty_n) begin
            rempty1 <= 1'b1;
            rempty <= 1'b1;
        end
        else begin
            rempty1 <= ~aempty_n;
            rempty <= rempty1;
        end
    end


    // almost empty
    always @(posedge clk, negedge aalmost_empty_n) begin
        if(~aalmost_empty_n) begin
            ralmost_empty1 <= 1'b1;
            ralmost_empty <= 1'b1;
        end
        else begin
            ralmost_empty1 <= ~aalmost_empty_n;
            ralmost_empty <= ralmost_empty1;
        end
    end

endmodule