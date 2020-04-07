module ALU(
				input [31:0]a,b,
				input [3:0]ALUSel,
				output [31:0]result
				);
//wire [31:0] r;
//multip mmm(a,b,r);
always@(*)
begin
case(ALUSel/*4*/)
4'b0000:result = a+b;//addsb;
4'b0001:result = a & b;//a4 & b4;
4'b0010:result = a | b;//a4 | b4;
4'b0011:result = a ^ b;//a4 ^ b4;
4'b0100:result = a >> b[4:0];//shft;
4'b0101:result = a;//a4;//$signed(a) >>> b[4:0];
4'b0110:result = a << b[4:0];//shft;
4'b0111:result = {31'b0,a<b};
4'b1000:result =b;//for lui(send b as it is)
4'b1001:result =a;// a % b;
4'b1010:result =a;// {{32'd0, a}*b} >> 32;
4'b1011:result = a* b;// (a * b) for mul
4'b1100:result = a - b;
4'b1101:result = b;
4'b1110:result = b;
4'b1111:result = b;
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
	if(Num==26'b1111000010000)
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

