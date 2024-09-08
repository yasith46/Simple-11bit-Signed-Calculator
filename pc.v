// Note: Not to be tested to SUB, as the display hasn't been config to signed numbers yet
// DO NOT USE CMD = 3'b010 other than to debug
//
// ON AN DE2-115
// Input configuration:
// --------------------------------------------------------------------------------------------
// For input mode (CMD = 3'b000)
//
//  +---------+++++++++++----+---------+------------------------------------------------------+
//  | 17   16 |/15///14/| 13 | 12   11 | 10    9    8    7    6    5    4    3    2    1    0 |
//  |   CMD   |// N/A //| CMD|   R0    |                  IMMEDIATE                           |
//  +---------+++++++++++----+---------+------------------------------------------------------+
//
//
// Operation configuration:
// --------------------------------------------------------------------------------------------
// For operation mode (CMD != 3'b000)
//
//  +---------+++++++++++----+---------+---------+---------++++++++++++++++++++++++++++++++++++
//  | 17   16 |/15///14/| 13 | 12   11 | 10    9 |  8    7 |//6////5////4////3////2////1////0/|
//  |   CMD   |// N/A //| CMD|   R0    |   R1    |   R2    ||/////////////  VOID  ////////////|
//  +---------+++++++++++----+---------+---------+---------++++++++++++++++++++++++++++++++++++
//
//
// Commands:
// --------------------------------------------------------------------------------------------
//    OPCODE  CMD     Description                             Status
// --------------------------------------------------------------------------------------------
//      000   LOAD    Loads the immediate to the register     -- Works
//      001   ADD     Addition of R1 and R2                   -- Works
//      010   SUB     Subtract R2 from R1            
//      011   AND     Bitwise AND R1 and R2                   -- Works
//      100   OR      Bitwise OR R1 and R2                    -- Works
//      101   SHOW    Show register R1                        -- Works
//
//  
// Function Buttons:
// --------------------------------------------------------------------------------------------
//  
//      KEY0  ENTER                                           -- Display doesn't stay (#1)
//      KEY2  CLR                                             -- Doesn't clear (#3) 
  

module pc(
	input  ENTER, CLR, CLK,
	input  [1:0]  REGSEL,
	input  [2:0]  CMD,
	input  [10:0] IN,
	output [6:0] SEG0, SEG1, SEG2, SEG3, SEG6, SEG7,
	output NEGSEG,
	output ZEROFLAG, ENTERLED,
	output reg SHOWNEGFLAG,
	output reg [17:0] LED
	);
	
	
	
	// ---- Display part ---	
	// BCD register
	reg  [10:0] BCD_IN;
	wire [15:0] BCD_OUT;
	
	bcd BCD0(
		.BIN(BCD_IN),
		.BCD(BCD_OUT)
	);
	
	// 7Segment Displays
	bcdto7seg D0(
		.IN(BCD_OUT[3:0]),
		.OUT(SEG0)
	);
	
	bcdto7seg D1(
		.IN(BCD_OUT[7:4]),
		.OUT(SEG1)
	);
	
	bcdto7seg D2(
		.IN(BCD_OUT[11:8]),
		.OUT(SEG2)
	);
	
	bcdto7seg D3(
		.IN(BCD_OUT[15:12]),
		.OUT(SEG3)
	);
	
	cmdto7seg DC(
		.CMD(CMD),
		.OUT({SEG7,SEG6})
	);
	
	reg [10:0] BCD_IN_I;
	reg SHOWNEGFLAG_INT;
	
	always@(IN or CMD or REGSEL) begin
		if (CMD == 3'b000) begin
			BCD_IN_I <= IN;
			SHOWNEGFLAG_INT <= IN[10];
		end else begin
		   BCD_IN_I <= 11'b0;
			SHOWNEGFLAG_INT <= 1'b0;
		end
		
		// LED Displaying the slide switches' input	
		LED <= {CMD[2:1],2'b0,CMD[0],REGSEL,IN};
	end

	assign ENTERLED = ~ENTER;		// LED for ENTER
	assign NEGSEG = ~SHOWNEGFLAG;	// Neagtive mark
	wire NEGFLAG;
	
	// --- ALU & Internal Registers ---
	wire [11:0] RESULT_E;
	alu ALU0(
		.A(ALU_A),
		.B(ALU_B),
		.CTRL(CMD),
		.RESULT(RESULT_E),
		.ZEROFLAG(ZEROFLAG),
		.NEGATIVEFLAG(NEGFLAG)
	);

	// Internal Registers
	reg [11:0] REG0, REG1, REG2, REG3;
	
	// ALU Registers
	reg [11:0] ALU_A, ALU_B;
	
	reg [11:0] REG0_E, REG1_E, REG2_E, REG3_E, ALU_A_E, ALU_B_E;
	always@(negedge ENTER) begin
		if (CMD == 3'b000) begin					// CMD: Ld
			case (REGSEL)
				2'b00  : REG0_E  <= {1'b0,IN};
				2'b01  : REG1_E  <= {1'b0,IN};
				2'b10  : REG2_E  <= {1'b0,IN};
				2'b11  : REG3_E  <= {1'b0,IN};
				default:;
			endcase
			
		end else if (CMD == 3'b101) begin		// CMD: Sh
			case (REGSEL)
				2'b00  : ALU_A_E  <= REG0;
				2'b01  : ALU_A_E  <= REG1;
				2'b10  : ALU_A_E  <= REG2;
				2'b11  : ALU_A_E  <= REG3;
				default:;
			endcase
			
		end else begin									// CMD: Other operations
			// ALU_A input
			case (IN[10:9])
				2'b00  : ALU_A_E <= REG0;
				2'b01  : ALU_A_E <= REG1;
				2'b10  : ALU_A_E <= REG2;
				2'b11  : ALU_A_E <= REG3;
				default: ALU_A_E <= 12'b0;
			endcase
			
			// ALU_B input
			case (IN[8:7])
				2'b00  : ALU_B_E <= REG0;
				2'b01  : ALU_B_E <= REG1;
				2'b10  : ALU_B_E <= REG2;
				2'b11  : ALU_B_E <= REG3;
				default: ALU_B_E <= 12'b0;
			endcase
			
			case (REGSEL)
				2'b00  : REG0_E  <= RESULT;
				2'b01  : REG1_E  <= RESULT;
				2'b10  : REG2_E  <= RESULT;
				2'b11  : REG3_E  <= RESULT;
				default:;
			endcase
		end
	end
	
	// Save value to register
	reg [11:0] RESULT;
	
	always@(posedge CLK) begin	
		if (ENTER == 1'b0) begin 	// When ENTERed
			REG0 <= REG0_E;
			REG1 <= REG1_E;
			REG2 <= REG2_E;
			REG3 <= REG3_E;
			ALU_A <= ALU_A_E;
			ALU_B <= ALU_B_E; 
			RESULT <= RESULT_E;
			BCD_IN <= RESULT[10:0];
			SHOWNEGFLAG <= NEGFLAG;
			
		end else begin					// Default
			REG0 <= REG0_E;
			REG1 <= REG1_E;
			REG2 <= REG2_E;
			REG3 <= REG3_E;
			ALU_A <= ALU_A_E;
			ALU_B <= ALU_B_E; 
			RESULT <= RESULT_E;
			BCD_IN <= BCD_IN_I;
			SHOWNEGFLAG <= SHOWNEGFLAG_INT;
		end
	end
endmodule 
			