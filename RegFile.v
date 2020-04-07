module registmem(
						input [4:0]rd,r1,r2,
						input [31:0]dataIn,
						input RegWEn,clk,AReset,
						output [31:0]data1,data2,DataReg5,DataReg11,DataReg13
						);
parameter p=32;

wire [31:0]regout[31:0];
wire [31:0]wreg_temp,wreg;
decoder dec(rd,RegWEn,wreg_temp);
assign wreg = {wreg_temp[31:1],1'b0};

genvar i;
generate for(i = 0; i < p; i = i + 1)begin:regfile
			if(i!=2)
			register #(.W(p),.d(0)) r(dataIn,clk,AReset,wreg[i],regout[i]);
			else
			register #(.W(p),.d(31)) r(dataIn,clk,AReset,wreg[i],regout[i]);//31 is max stack size
end
endgenerate

assign data1 = regout[r1];
assign data2 = regout[r2];
assign DataReg5 = regout[17];
assign DataReg11 = regout[27];
assign DataReg13 = regout[13];
endmodule

module decoder(
					input [4:0]dec_in,
					input enable,
					output [31:0]dec_out
					);
assign dec_out = enable?(1<<dec_in):32'h0;
endmodule

module register(
					input [W-1:0]data,
					input clock_signal,reset,we,
					output reg [W-1:0]register_variable
					);
parameter W = 32,d = 0;
initial register_variable = 0;
always @ (negedge reset or posedge clock_signal)
begin
	// Reset whenever the reset signal goes low, regardless of the clock
	if (!reset)
		begin
			register_variable <= d;
		end
	else if(we)
		begin
			register_variable <= data;
		end
	else
		begin
			register_variable <= register_variable;
		end
end
endmodule

module upcounter(input clk,rst,Pcsel,input [13:0]load,output [13:0]add);
initial add = 0;
always @ (negedge rst or posedge clk)
begin
	// Reset whenever the reset signal goes low, regardless of the clock
	if (!rst)
		begin
			add <= 0;
		end
	else if(Pcsel)
		begin
			add <= load;
		end
	else
		begin
			add <= add+3'b100;
		end
end
endmodule

module mux3(input a,b,c,d,e,f,g,h,input [2:0]sel,output out);
always@(*)
begin
case(sel)
3'b000:out= a;
3'b001:out= b;
3'b010:out= c;
3'b011:out= d;
3'b100:out= e;
3'b101:out= f;
3'b110:out= g;
3'b111:out= h;
endcase
end
endmodule

module registerS(
					input [W-1:0]data,
					input clk,reset,we,
					output reg [W-1:0]q
					);
parameter W = 32,num=3;

wire [W-1:0]dt[num:0];
assign dt[0]=data;
genvar i;
generate for(i = 0; i < num; i = i + 1)begin:re
			register #(W) u(dt[i],clk,reset,1'b1,dt[i+1]);
end
endgenerate
assign q = dt[num];
endmodule
