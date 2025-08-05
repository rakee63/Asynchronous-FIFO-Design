`timescale 1ns / 1ps

//asynchronous read and write pointer comparator




module async_comp #(parameter n=4)(
    input wrst_n,
    input [n:0] w_gptr, r_gptr, w_galmost_ptr, r_galmost_ptr,
    output afull_n, aempty_n, aalmost_full_n, aalmost_empty_n
);

    assign cmp = (w_gptr[n-2:0] == r_gptr[n-2:0]);
    
    assign aempty_n = (wrst_n & ~(cmp & (w_gptr[n:n-1]==r_gptr[n:n-1])));
    
    assign afull_n = ~(wrst_n & (cmp & (w_gptr[n:n-1]==~(r_gptr[n:n-1]))));


    assign aalmost_full_n = (~(wrst_n && (r_gptr[n-2:0] == w_galmost_ptr[n-2:0]) && (r_gptr[n:n-1] == ~w_galmost_ptr[n:n-1]))) & afull_n;

    assign aalmost_empty_n = (wrst_n && ~((w_gptr[n-2:0] == r_galmost_ptr[n-2:0]) && (w_gptr[n:n-1] == r_galmost_ptr[n:n-1]))) & aempty_n;

endmodule
