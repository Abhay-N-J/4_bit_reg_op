`timescale 1 ns / 100 ps
`define TESTVECS 8
`include "main.v"

module tb;

    reg clk, reset, load;
    reg [1:0]s;
    reg [3:0]reg_in;
    wire [3:0]reg_out;
    reg [6:0] test_vecs [0:(`TESTVECS-1)];

    integer i;

    initial begin 
        $dumpfile("tb_proj.vcd"); 
        $dumpvars(0,tb); 
    end

    initial begin reset = 1'b1; #12.5 reset = 1'b0; end
	initial clk = 1'b0; always #5 clk =~ clk;

    initial begin
		test_vecs[0][6]=1'b0;	test_vecs[0][5:4]=2'b00;	test_vecs[0][3:0]=4'h5;
		test_vecs[1][6]=1'b1;	test_vecs[1][5:4]=2'b01;	test_vecs[1][3:0]=4'h6;
		test_vecs[2][6]=1'b0;	test_vecs[2][5:4]=2'b10;	test_vecs[2][3:0]=4'h7;
		test_vecs[3][6]=1'b1;	test_vecs[3][5:4]=2'b11;	test_vecs[3][3:0]=4'h8;
		test_vecs[4][6]=1'b1;	test_vecs[4][5:4]=2'b00;	test_vecs[4][3:0]=4'h9;
		test_vecs[5][6]=1'b1;	test_vecs[5][5:4]=2'b01;	test_vecs[5][3:0]=4'ha;
		test_vecs[6][6]=1'b1;	test_vecs[6][5:4]=2'b10;	test_vecs[6][3:0]=4'hb;
		test_vecs[7][6]=1'b1;	test_vecs[7][5:4]=2'b11;	test_vecs[7][3:0]=4'hc;
		//test_vecs[0][6]=1'b0;	test_vecs[0][5:4]=2'b00;	test_vecs[0][3:0]=4'hd;
	end

    initial {load, s, reg_in} = 0;

    main m(clk,reset,load,s,reg_in,reg_out);

    initial begin
        $monitor("clk=>%d reset=>%d load=>%d s=>%b reg_in=>%b reg_out=>%b",clk,reset,load,s,reg_in,reg_out);
        for(i=0;i<`TESTVECS;i=i+1)
            begin #10{load, s, reg_in}=test_vecs[i]; end
        #100 $finish;
    end
    // initial begin
    //     $monitor("clk=>%d reset=>%d load=>%d s=>%b reg_in=>%b reg_out=>%b, %d",clk,reset,load,s,reg_in,reg_out,i);
    //     for(i=0;i<20;i=i+1) begin
    //         #5;
    //         clk =~ clk;
    //         if(clk) begin
    //             reg_in = $urandom%16; 
    //             s = $urandom%4;
    //         end  
    //     end $finish;
    // end    

endmodule