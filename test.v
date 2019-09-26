module test(input [1:1]SW,output [35:0]GPIO_0,output [1:1]LEDR);

assign LEDR[1] = SW[1];
assign GPIO_0[35:0] = {36{SW[1]}};
//assign PIN_C22 = 1'b1;
//assign PIN_L18 = 1'b1;
endmodule 


module tb();
reg [31:0]d3,d4;
reg clk,AReset;
wire [31:0]r;
LPMaddersubtractorL s(AReset,1'b1,clk,d3,d4,r);

initial
begin
AReset=1;
d3=0;
d4=5;
clk=0;
#100 clk=1;
#100 clk=0;
#100 clk=1;
#100 clk=0;
#100 clk=1;
#100 clk=0;
#100 clk=1;
#100 clk=0;
#100 clk=1;
#100 clk=0;
#100 clk=1;
#100 clk=0;
#100 clk=1;
#100 clk=0;
#100 clk=1;
#100 clk=0;
end
endmodule
