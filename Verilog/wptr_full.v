`timescale 1ns / 1ps

// wptr (write address) and full (fifo full signal)




module wptr_full #(parameter n=4)(
    input clk,
    input wrst_n,
    input winc,
    input afull_n, aalmost_full_n,
    output [n:0] w_gptr, w_galmost_ptr,
    output [n-1:0] w_bptr,
    output reg wfull, walmost_full
);

//    reg wfull1, wfull2;

    reg wfull1, walmost_full1;

    gray_counter #(.n(n)) write_counter (
        // inputs
        .clk(clk),
        .rst_n(wrst_n),
        .inc(winc),
        .full_empty(wfull),
        
        // outputs
        .bptr(w_bptr),
        .gptr(w_gptr),
        .galmost_ptr(w_galmost_ptr)
    );

//    assign wfull = wfull2 | ~afull_n;

//    always @(posedge clk, negedge wrst_n) begin
//        if(~wrst_n) begin
//            wfull1 <= 1'b0;
//            wfull2 <= 1'b0;
//        end
//        else if(~afull_n) begin
//            wfull1 <= 1'b1;
//            wfull2 <= 1'b1;
//        end
//        else begin
//            wfull1 <= ~afull_n;
//            wfull2 <= wfull1;
//        end
//    end
    
    always @(posedge clk or negedge wrst_n or negedge afull_n) begin
        if      (!wrst_n) begin
                            wfull1 <= 0;  // asynchronous reset
                            wfull <= 0;
                          end
        else if (!afull_n) begin
                            wfull1 <= 1;  // asynchronous set
                            wfull <= 1;
                           end
        else             begin
                            wfull1 <= ~afull_n;
                            wfull <= wfull1;
                         end
    end
    
//    synopsys translate_off
    always @(wrst_n or afull_n) begin
        if   (wrst_n && !afull_n) force wfull1 = 1;
        else                 release wfull1;
    end
    
    always @(wrst_n or afull_n) begin
        if   (wrst_n && !afull_n) force wfull = 1;
        else                 release wfull;
    end
//    synopsys translate_on



    // almost full
    always @(posedge clk or negedge wrst_n or negedge aalmost_full_n) begin
        if      (!wrst_n) begin
                            walmost_full1 <= 0;  // asynchronous reset
                            walmost_full <= 0;
                          end
        else if (!aalmost_full_n) begin
                            walmost_full1 <= 1;  // asynchronous set
                            walmost_full <= 1;
                           end
        else             begin
                            walmost_full1 <= ~aalmost_full_n;
                            walmost_full <= walmost_full1;
                         end
    end
    
//    synopsys translate_off
    always @(wrst_n or aalmost_full_n) begin
        if   (wrst_n && !aalmost_full_n) force walmost_full1 = 1;
        else                 release walmost_full1;
    end
    
    always @(wrst_n or aalmost_full_n) begin
        if   (wrst_n && !aalmost_full_n) force walmost_full = 1;
        else                 release walmost_full;
    end
//    synopsys translate_on

endmodule