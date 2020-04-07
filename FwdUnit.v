module FwdUnit(
					input [4:0]Id_ExR,
					input [4:0]Ex_Mem_Rd, Mem_Wb_Rd,Wb_Rd,
					input [31:0]Ex_Mem_data,Mem_Wb_data,Wb_data,data_in,
					output reg [31:0]data_o
					);
always@(*)
	begin
		if(Ex_Mem_Rd == Id_ExR && Id_ExR != 5'b0)
			data_o = Ex_Mem_data;
		else if(Mem_Wb_Rd == Id_ExR && Id_ExR != 5'b0)
			data_o = Mem_Wb_data;
		else if(Wb_Rd == Id_ExR && Id_ExR != 5'b0)
			data_o = Wb_data;
		else
			data_o = data_in;
	end
endmodule
