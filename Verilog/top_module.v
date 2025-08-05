`timescale 1ns / 1ps

//FIFO wrapper




module top_module #(parameter n=4,
                    parameter DATA=8,
                    parameter DEPTH=16) (
    input wclk, rclk,
    input wrst_n, rrst_n,
    input winc, rinc,
    input [DATA-1:0] wdata,
    output [DATA-1:0] rdata,
    output wfull, rempty, walmost_full, ralmost_empty
    // output [n-1:0] w_bptr, r_bptr
);
  
    wire [n-1:0] w_bptr, r_bptr;
    wire [n:0] w_gptr, r_gptr, w_galmost_ptr, r_galmost_ptr;
    wire afull_n, aempty_n, aalmost_full_n, aalmost_empty_n;
    wire wena;
      
    // fifomem #(.n(n), .DATA(DATA), .DEPTH(DEPTH)) fifo_memory (
    //     .clk(wclk),
    //     .wclken(winc),
    //     .waddr(w_bptr),
    //     .raddr(r_bptr),
    //     .wdata(wdata),

    //     .rdata(rdata)
    // );

    assign wena = winc & ~wfull;

    dist_mem_gen_0 fifomem (
        // inputs
        .a(w_bptr),
        .d(wdata),
        .dpra(r_bptr),
        .clk(wclk),
        .we(1'b1),
        .i_ce(wena),

        // outputs
        .dpo(rdata)
    );

    wptr_full #(.n(n)) write_pointer_full (
        // inputs
        .clk(wclk),
        .wrst_n(wrst_n),
        .winc(winc),
        .afull_n(afull_n),
        .aalmost_full_n(aalmost_full_n),

        // outputs
        .w_gptr(w_gptr),
        .w_galmost_ptr(w_galmost_ptr),
        .w_bptr(w_bptr),
        .wfull(wfull),
        .walmost_full(walmost_full)
    );

    rptr_empty #(.n(n)) read_pointer_empty (
        // inputs
        .clk(rclk),
        .rrst_n(rrst_n),
        .rinc(rinc),
        .aempty_n(aempty_n),
        .aalmost_empty_n(aalmost_empty_n),

        // outputs
        .r_gptr(r_gptr),
        .r_galmost_ptr(r_galmost_ptr),
        .r_bptr(r_bptr),
        .rempty(rempty),
        .ralmost_empty(ralmost_empty)
    );

    async_comp #(.n(n)) compare_block (
        // inputs
        .wrst_n(wrst_n),
        .w_gptr(w_gptr),
        .r_gptr(r_gptr),
        .w_galmost_ptr(w_galmost_ptr),
        .r_galmost_ptr(r_galmost_ptr),

        // outputs
        .afull_n(afull_n),
        .aempty_n(aempty_n),
        .aalmost_full_n(aalmost_full_n),
        .aalmost_empty_n(aalmost_empty_n)
    );

endmodule
