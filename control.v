module controlUnit(input [31:0]instruction,input BrLT,BrEq,
						output RegWEn,Bsel,Asel,MemRW,output [2:0]ImmSel,PCSel,output [3:0]ALUSel,output [1:0]WBSel
						);

wire [4:0]opCode;
wire [2:0]funct3;
wire funct7_1;
assign opCode = instruction[6:2];
assign funct3 = instruction[14:12];
assign funct7_1 = instruction[30];

parameter R=5'b01100,I=5'b00100,Ild=5'b00000,Ijlr=5'b11001,S=5'b01000,SB=5'b11000,U=5'b01101,UJ=5'b11011;

always@(*)
begin
case(opCode)
R:
begin
	PCSel=3'b0; RegWEn=1; Bsel=0; Asel=0; MemRW=0; ImmSel=3'b000; WBSel=2'b1;
		case(funct3)
		3'b000:ALUSel=funct7_1?4'b1100:4'b0000;//add,sub
		3'b001:ALUSel=4'b0110;						//sll
		3'b101:ALUSel=funct7_1?4'b0101:4'b0100;//srl,ara
		3'b010:ALUSel=4'b0111;						//slt
		3'b110:ALUSel=4'b0010;						//or
		3'b111:ALUSel=4'b0001;						//and
		default:ALUSel=4'b0000;
 		endcase
end
I:
begin
	PCSel=3'b0; RegWEn=1;Bsel=1;    Asel=0; MemRW=0;   ImmSel=3'b000;    WBSel=2'b1;
		case(funct3)
		3'b000:ALUSel=4'b0000;//addi
		3'b001:ALUSel=4'b0110;//slli
		3'b010:ALUSel=4'b0111;//slti
		3'b101:ALUSel=funct7_1?4'b0101:4'b0100;//srli,srai
		3'b110:ALUSel=4'b0010;//ori
		3'b111:ALUSel=4'b0001;//andi
		default:ALUSel=4'b0000;
		endcase
end
Ild:
begin
	PCSel=3'b0; RegWEn=instruction[0]; Bsel=1;    Asel=0; MemRW=0;   ImmSel=3'b000;    WBSel=2'b0;
		ALUSel=4'b0000;//add
end
Ijlr:
begin
	PCSel=3'b1; RegWEn=1;  Bsel=1;  Asel=0; MemRW=0;   ImmSel=3'b000;    WBSel=2'b10;
		ALUSel=4'b0000;//add
end
S:
begin
	PCSel=3'b0; RegWEn=0; Bsel=1;    Asel=0; MemRW=1;   ImmSel=3'b001;    WBSel=2'b1;
		ALUSel=4'b0000;//add
end
SB:
begin
	RegWEn=0;  ALUSel=4'b0000;   Bsel=1;    Asel=1; MemRW=0;   ImmSel=3'b010;    WBSel=2'b1;
		case(funct3)
		3'b000:PCSel=3'b010; //breq
		3'b001:PCSel=3'b011; //brne
		3'b100:PCSel=3'b100; //brlt
		3'b101:PCSel=3'b101; //bge
		default:PCSel=3'b0; 
		endcase
end
U:
begin
	PCSel=3'b0; RegWEn=1;  Bsel=1;  Asel=1; MemRW=0;   ImmSel=3'b100;    WBSel=2'b01;
		ALUSel=4'b1000;//add0, For lui,imm+0
end
UJ:
begin
	PCSel=3'b1; RegWEn=1; Bsel=1;  Asel=1; MemRW=0;   ImmSel=3'b011;    WBSel=2'b10;
		ALUSel=4'b0000;//add
end
default:
begin PCSel=3'b0; RegWEn=0; Bsel=1'bx; Asel=1'bx; MemRW=0;   ImmSel=3'bx; ALUSel=4'b0000; WBSel=2'bx; end
endcase
end
endmodule
