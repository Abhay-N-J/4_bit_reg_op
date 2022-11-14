`include "lib.v"

module mux4_1 (
    input wire i1,i2,i3,i4, 
    input wire j1, j0, 
    output wire o
);
  wire  t0, t1;
  mux2 mux2_0 (i1, i2, j0, t0);
  mux2 mux2_1 (i3, i4, j0, t1);
  mux2 mux2_2 (t0, t1, j1, o);
endmodule

module mux(
    input wire [1:0]s, 
    input wire [3:0]reg_in,
    output  wire [3:0]reg_out
);

    mux4_1 m0(reg_in[0], ~(reg_in[0]), reg_in[1], 1'b0     , s[1], s[0], reg_out[0]);
    mux4_1 m1(reg_in[1], ~(reg_in[1]), reg_in[2], reg_in[0], s[1], s[0], reg_out[1]);
    mux4_1 m2(reg_in[2], ~(reg_in[2]), reg_in[3], reg_in[1], s[1], s[0], reg_out[2]);
    mux4_1 m3(reg_in[3], ~(reg_in[3]), 1'b0     , reg_in[2], s[1], s[0], reg_out[3]);

endmodule

module data(
    input wire clk, reset, load, 
    input wire [3:0]reg_in,
    output wire [3:0]reg_out
);

    dfrl d1(clk, reset, load, reg_in[0], reg_out[0]);
    dfrl d2(clk, reset, load, reg_in[1], reg_out[1]);
    dfrl d3(clk, reset, load, reg_in[2], reg_out[2]);
    dfrl d4(clk, reset, load, reg_in[3], reg_out[3]);

endmodule

module main(
    input wire clk, reset, load, 
    input wire [1:0]s, 
    input wire [3:0]reg_in, 
    output wire [3:0]reg_out 
);
    wire [3:0]w;
    mux m(s, reg_in, w);

    data d(clk, reset, load, w, reg_out);


endmodule