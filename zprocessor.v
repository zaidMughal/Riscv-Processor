module zprocessor(input CLOCK_50,input [3:3]KEY,output [31:0]w,instructoin,alu1,alu2,aluo,datain11,immout,output [2:0]pcl,output [7:0]imemaddress,output [0:6]HEX0,HEX1,HEX2,HEX3,output [9:0]LEDR,output [7:0]LEDG
,output [35:11]GPIO_0);
//GPIO_0 14=PIN_B18,  18=PIN_B20,  20=PIN_C22,  22=PIN_D22,  32=PIN_J22,  34=PIN_K22,  36=PIN_J20,  38=PIN_K20,  40=PIN_L18
assign GPIO_0[11] = 1'b1;
assign GPIO_0[13] = 1'bx;
assign GPIO_0[15] = datain11[5];//Rs
assign GPIO_0[17] = 1'b0;//GND
assign GPIO_0[19] = datain11[4];//En
assign GPIO_0[21] = 1'bx;
assign GPIO_0[23] = 1'bx;
assign GPIO_0[25] = 1'bx;
assign GPIO_0[27] = datain11[0];//D4
assign GPIO_0[29] = datain11[1];//D5
assign GPIO_0[31] = datain11[2];//D6
assign GPIO_0[33] = datain11[3];//D7
assign GPIO_0[35] = 1'b1;//Vcc

assign imemaddress = add;
assign immout = imm;
assign aluo = ALU_Branch;
assign alu1=a;
assign alu2=b;
assign pcl = PCSelL4;
assign instructoin = instruction;
assign w = wb;
wire clk;
assign clk = CLOCK_50;

wire reset;
assign reset = KEY[3];
//Counter26bit cc(CLOCK_50,clk);
//-----------------------------Layer 1----------------------------------
wire [9:0]add;
wire [7:0]addin;
wire [31:0]instruction;
wire pcsel;

mux3 mm(1'b0,1'b1,BrEq,~BrEq,BrLt,~BrLt,1'b0,1'b0,PCSelL4,pcsel);
upcounter up(clk,reset,pcsel,ALU_Branch[9:0],add);
assign addin = add>>2;
romWCounter t(addin,clk,instruction);

registerS #(10,2) addrL1r(add,clk,reset,1'b1,addrL2);//we need 1 extra ff to enter PC value (not PC+4) in SB format 
register #(32) instL1r(instruction,clk,reset,1'b1,instL2); 
//-----------------------------Layer 2----------------------------------
wire [9:0]addrL2;
wire [31:0]instL2;
wire [31:0]data1,data2,imm,wb;
wire RegWEn,BrUn,BrLt,BrEq,Bsel,Asel,MemRW;
wire [2:0]ImmSel,PCSel;
wire [3:0]ALUSel;
wire [1:0]WBSel;

controlUnit cu(instL2,BrLt,BrEq,RegWEn,Bsel,Asel,MemRW,ImmSel,PCSel,ALUSel,WBSel);
registmem r(.rd(rdL5),.r1(instL2[19:15]),.r2(instL2[24:20]),.dataIn(wb),.RegWEn(RegWEnL5),.clk(clk),.AReset(reset),.data1(data1),.data2(data2),.DataReg11(datain11));//
//Brancher br(data1,data2,BrUn,BrEq,BrLt);
brnchcomp br(~reset,clk,data1,data2,BrEq,BrLt);
ImmGen i(instL2,ImmSel,imm);

register #(10) addrL2r(addrL2,clk,reset,1'b1,addrL3); 
register #(32) data1L2r(data1,clk,reset,1'b1,data1L3);
register #(32) data2L2r(data2,clk,reset,1'b1,data2L3);
register #(32) immL2r(imm,clk,reset,1'b1,immL3);
register #(3) PCSelL2r(PCSel,clk,reset,1'b1,PCSelL3);
register #(1) RegWEnL2r(RegWEn,clk,reset,1'b1,RegWEnL3);
register #(1) BselL2r(Bsel,clk,reset,1'b1,BselL3);
register #(1) AselL2r(Asel,clk,reset,1'b1,AselL3);
register #(1) MemRWL2r(MemRW,clk,reset,1'b1,MemRWL3);
register #(4) ALUSelL2r(ALUSel,clk,reset,1'b1,ALUSelL3);
register #(2) WBSelL2r(WBSel,clk,reset,1'b1,WBSelL3);
register #(5) rdL2r(instL2[11:7],clk,reset,1'b1,rdL3);
//-----------------------------Layer 3----------------------------------
wire [9:0]addrL3;
wire [31:0]immL3,data1L3,data2L3,ALU_Branch,a,b;
wire RegWEnL3,BselL3,AselL3,MemRWL3;
wire [3:0]ALUSelL3;
wire [1:0]WBSelL3;
wire [4:0]rdL3;
wire [2:0]PCSelL3;

assign a = AselL3 ? {22'b0,addrL3} : data1L3;
assign b = BselL3 ? immL3 : data2L3;
ALU aaloo(a,b,clk,reset,ALUSelL3,ALU_Branch);


assign ALUResultL4 = ALU_Branch;//register #(32) ALUResL3r(ALU_Branch,clk,reset,1'b1,ALUResultL4);
registerS #(32,2) data2L3r(data2L3,clk,reset,1'b1,data2L4);
registerS #(3,2) PCSelL3r(PCSelL3,clk,reset,1'b1,PCSelL4);
registerS #(1,2) RegWEnL3r(RegWEnL3,clk,reset,1'b1,RegWEnL4);
registerS #(1,2) MemRWL3r(MemRWL3,clk,reset,1'b1,MemRWL4);
registerS #(2,2) WBSelL3r(WBSelL3,clk,reset,1'b1,WBSelL4);
registerS #(5,2) rdL3r(rdL3,clk,reset,1'b1,rdL4);
registerS #(10,2) addrL3r(addrL3,clk,reset,1'b1,addrL4);//1 less because we want to store PC+4,not PC

//-----------------------------Layer 4----------------------------------
wire [31:0]data2L4,ALUResultL4,DMEMout;
wire RegWEnL4,MemRWL4;
wire [2:0]PCSelL4;
wire [1:0]WBSelL4;
wire [4:0]rdL4;
wire [9:0]addrL4;

DMEM d(ALU_Branch[4:0],clk,data2L4,MemRWL4,DMEMout);

register #(32) DMEMoutL4r(DMEMout,clk,reset,1'b1,DMEMoutL5);
register #(32) ALUResL4r(ALUResultL4,clk,reset,1'b1,ALUResultL5);
register #(2) WBSelL4r(WBSelL4,clk,reset,1'b1,WBSelL5);
///register #(3) PCSelL4r(PCSelL4,clk,reset,1'b1,PCSelL5);
register #(1) RegWEnL4r(RegWEnL4,clk,reset,1'b1,RegWEnL5);
register #(5) rdL4r(rdL4,clk,reset,1'b1,rdL5);
register #(10) addrL4r(addrL4,clk,reset,1'b1,addrL5);

//-----------------------------Layer 5----------------------------------
wire [31:0]DMEMoutL5,ALUResultL5;
wire [1:0]WBSelL5;
wire PCSelL5,RegWEnL5;
wire [4:0]rdL5;
wire [9:0]addrL5;

assign wb = WBSelL5[1] ? (WBSelL5[0] ? addrL5 : addrL5) : (WBSelL5[0] ? ALUResultL5 : DMEMout); 


//Seg7 l(datain11[3:0],HEX0);
//Seg7 m(datain11[7:4],HEX1);
//Seg7 n(datain11[11:8],HEX2);
//Seg7 o(datain11[15:12],HEX3);
Seg7 l(4'b0,HEX0);
Seg7 m(4'b0,HEX1);
Seg7 n(4'b0,HEX2);
Seg7 o(4'b0,HEX3);
assign LEDR[7:0] = 8'b0;
assign LEDG[7:0] = 8'b0;
endmodule

