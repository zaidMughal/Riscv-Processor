module ALU(
				input [31:0]a,b,
				input clk,Areset,
				input [3:0]ALUSel,
				output [31:0]result
				);
wire [31:0]addsb,addsb0,shft,a4,b4;
wire [3:0]ALUSel4;
wire LT;
LPMaddersubtractorL t(~Areset,~ALUSel[2],clk,a,b,addsb);
LPMaddersubtractorL t0(~Areset,1'b1,clk,32'b0,b,addsb0);
comp4 f(~Areset,clk,a,b,LT);
shift4 s(~Areset,clk,a,~ALUSel[1],b[4:0],shft);
registerS #(32,2) ar(a,clk,Areset,1'b1,a4);
registerS #(32,2) br(b,clk,Areset,1'b1,b4);
registerS #(4,2) alr(ALUSel,clk,Areset,1'b1,ALUSel4);

always@(a4,b4,addsb,shft,LT,ALUSel4,addsb0)
begin
case(ALUSel4)
4'b0000:result = addsb;
4'b0001:result = a4 & b4;
4'b0010:result = a4 | b4;
4'b0011:result = a4 ^ b4;
4'b0100:result = shft;
4'b0101:result = a4;//$signed(a) >>> b[4:0];
4'b0110:result = shft;//a << b[4:0];
4'b0111:result = {31'b0,LT};
4'b1000:result =addsb0;// a / b;
4'b1001:result =a4;// a % b;
4'b1010:result =a4;// {{32'd0, a}*b} >> 32;
4'b1011:result =a4;// (a * b);
4'b1100:result = addsb;
4'b1101:result = b4;
4'b1110:result = b4;
4'b1111:result = b4;
endcase
end
endmodule

module Seg7(s,HEX0);
input [3:0]s;
output reg[6:0]HEX0;
always@(*)
case(s)
4'b0000: HEX0 = 7'b0000001;
4'b0001: HEX0 = 7'b1001111;
4'b0010: HEX0 = 7'b0010010;
4'b0011: HEX0 = 7'b0000110;
4'b0100: HEX0 = 7'b1001100;//4
4'b0101: HEX0 = 7'b0100100;
4'b0110: HEX0 = 7'b0100000;
4'b0111: HEX0 = 7'b0001111;
4'b1000: HEX0 = 7'b0000000;
4'b1001: HEX0 = 7'b0000100;
4'b1010: HEX0 = 7'b0001000;//A
4'b1011: HEX0 = 7'b1100000;//b
4'b1100: HEX0 = 7'b0110001;//C
4'b1101: HEX0 = 7'b1000010;//d
4'b1110: HEX0 = 7'b0110000;//E
4'b1111: HEX0 = 7'b0111000;//F
endcase
endmodule


module Counter26bit(input clk,output reg Count);
reg [25:0]Num;
initial Num=26'b0;
initial Count=1'b0;

always@(posedge clk)
	begin
	if(Num==26'b10111110101111000010000)
		begin
		Count<=~Count;
		Num<=26'b0;
		end
	else
		begin
		Num<=Num+26'b001;//26'b1011111010111100001000000;
		end
	end
endmodule 

