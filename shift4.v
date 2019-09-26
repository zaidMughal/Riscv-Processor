// megafunction wizard: %LPM_CLSHIFT%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: LPM_CLSHIFT 

// ============================================================
// File Name: shift4.v
// Megafunction Name(s):
// 			LPM_CLSHIFT
//
// Simulation Library Files(s):
// 			
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 13.0.1 Build 232 06/12/2013 SP 1 SJ Web Edition
// ************************************************************


//Copyright (C) 1991-2013 Altera Corporation
//Your use of Altera Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Altera Program License 
//Subscription Agreement, Altera MegaCore Function License 
//Agreement, or other applicable license agreement, including, 
//without limitation, that your use is for the sole purpose of 
//programming logic devices manufactured by Altera and sold by 
//Altera or its authorized distributors.  Please refer to the 
//applicable agreement for further details.


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module shift4 (
	aclr,
	clock,
	data,
	direction,
	distance,
	result);

	input	  aclr;
	input	  clock;
	input	[31:0]  data;
	input	  direction;
	input	[4:0]  distance;
	output	[31:0]  result;

	wire [31:0] sub_wire0;
	wire [31:0] result = sub_wire0[31:0];

	lpm_clshift	LPM_CLSHIFT_component (
				.aclr (aclr),
				.clock (clock),
				.data (data),
				.direction (direction),
				.distance (distance),
				.result (sub_wire0)
				// synopsys translate_off
				,
				.clken (),
				.overflow (),
				.underflow ()
				// synopsys translate_on
				);
	defparam
		LPM_CLSHIFT_component.lpm_pipeline = 2,
		LPM_CLSHIFT_component.lpm_shifttype = "LOGICAL",
		LPM_CLSHIFT_component.lpm_type = "LPM_CLSHIFT",
		LPM_CLSHIFT_component.lpm_width = 32,
		LPM_CLSHIFT_component.lpm_widthdist = 5;


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone II"
// Retrieval info: PRIVATE: LPM_SHIFTTYPE NUMERIC "0"
// Retrieval info: PRIVATE: LPM_WIDTH NUMERIC "32"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: lpm_widthdist NUMERIC "5"
// Retrieval info: PRIVATE: lpm_widthdist_style NUMERIC "0"
// Retrieval info: PRIVATE: new_diagram STRING "1"
// Retrieval info: PRIVATE: port_direction NUMERIC "2"
// Retrieval info: LIBRARY: lpm lpm.lpm_components.all
// Retrieval info: CONSTANT: LPM_PIPELINE NUMERIC "4"
// Retrieval info: CONSTANT: LPM_SHIFTTYPE STRING "LOGICAL"
// Retrieval info: CONSTANT: LPM_TYPE STRING "LPM_CLSHIFT"
// Retrieval info: CONSTANT: LPM_WIDTH NUMERIC "32"
// Retrieval info: CONSTANT: LPM_WIDTHDIST NUMERIC "5"
// Retrieval info: USED_PORT: aclr 0 0 0 0 INPUT NODEFVAL "aclr"
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL "clock"
// Retrieval info: USED_PORT: data 0 0 32 0 INPUT NODEFVAL "data[31..0]"
// Retrieval info: USED_PORT: direction 0 0 0 0 INPUT NODEFVAL "direction"
// Retrieval info: USED_PORT: distance 0 0 5 0 INPUT NODEFVAL "distance[4..0]"
// Retrieval info: USED_PORT: result 0 0 32 0 OUTPUT NODEFVAL "result[31..0]"
// Retrieval info: CONNECT: @aclr 0 0 0 0 aclr 0 0 0 0
// Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
// Retrieval info: CONNECT: @data 0 0 32 0 data 0 0 32 0
// Retrieval info: CONNECT: @direction 0 0 0 0 direction 0 0 0 0
// Retrieval info: CONNECT: @distance 0 0 5 0 distance 0 0 5 0
// Retrieval info: CONNECT: result 0 0 32 0 @result 0 0 32 0
// Retrieval info: GEN_FILE: TYPE_NORMAL shift4.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL shift4.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL shift4.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL shift4.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL shift4_inst.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL shift4_bb.v TRUE
