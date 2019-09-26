module ImmGen(
					input [31:0]instr,
					input [2:0]ImmSel,
					output [31:0]out
					);
always@(*)
begin
case(ImmSel)
3'b000: begin out = {{20{instr[31]}},instr[31:20]}; end
3'b001: begin out = {{20{instr[31]}},instr[31:25],instr[11:7]}; end
3'b010: begin out = {{19{instr[31]}},instr[31],instr[7],instr[30:25],instr[11:8],1'b0}; end
3'b011: begin out = {{11{instr[31]}},instr[31],instr[19:12],instr[20],instr[30:21],1'b0}; end//UJ
3'b100: begin out = {instr[31:12],12'b0}; end//U

default: out = 32'hffffffff;
endcase
end
endmodule 