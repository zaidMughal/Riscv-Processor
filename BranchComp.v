module Brancher(input [31:0]a,b,
					input Brun,
					output Breq,BrLt
					);
assign Breq = (a==b);
assign BrLt = (a<b);
endmodule
