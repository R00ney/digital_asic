/* Neal O'Hara
** Notes for Lesson 3: Verilog
** Code samples
** 01/25/2014
*/

module counter (clock, in, latch, dec, zero)

input clock;
input [3:0] in;
input latch;
input dec;
output zero;

reg [3:0] value;
wire zero;

always@ (posedge clock)
	begin
		if (latch) value <=in;
		else if (dec && !zero) value <= value - 1'b1;
	end

assign 	zero = (value == 4'b0);
endmodule //counter




include "count.v" //not needed for modelsim sim?
module test_fixture;
reg clock100;
reg latch, dec;
reg [3:0] in;
wire zero;
initial begin
//save waves as vcd files. Not needed if modelsim is used as sim. Used with cadence.
$dumpfile("count.vcd");
$dumpvars;
clock100=0;
latch =  0;
dec = 0;
in = 4'b0010;
#16 latch =1;
#10 latch = 0;
#10 dec = 1;
# if (!zero) $display("error in zero flag\n");
# 100 $finish;
end
allways #5 clock100 = ~clock100; //10ns clock
//intianiate modeuls
counter u1(.clock(clock100), .in(in), .latch(latch), .dec(dec), .zero(zero));
endmodule //test_fixture

