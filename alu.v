module alu(
		input [11:0] A,
		input [11:0] B,
		input [ 2:0] CTRL,
	
		output reg [11:0] RESULT,
		output ZEROFLAG, NEGATIVEFLAG
	);
	
	
	wire [11:0] RESULT_AND;
	wire [11:0] RESULT_OR;
	wire [11:0] RESULT_SUMSUB;
	
	// Logic of AND and OR
	assign RESULT_OR = A | B;
	
	
	// Logic for subtraction 
	reg CIN;
	wire COUT0,COUT1,COUT2,COUT3;
	wire [11:0] B_INT;
		
	assign B_INT = B ^ {12{CIN}};
	
	// Adders and subtractors	
	cla cla0 (
		.A( A[3:0] ),
		.B( B_INT[3:0] ),
		.CIN( CIN ),
		.COUT( COUT0 ),
		.SUM( RESULT_SUMSUB[3:0] ),
		.AND_OUT( RESULT_AND[3:0] )
	);
	
	cla cla1 (
		.A( A[7:4] ),
		.B( B_INT[7:4] ),
		.CIN( COUT0 ),
		.COUT( COUT1 ),
		.SUM( RESULT_SUMSUB[7:4] ),
		.AND_OUT( RESULT_AND[7:4] )
	);
	
	cla cla2 (
		.A( A[11:8] ),
		.B( B_INT[11:8] ),
		.CIN( COUT1 ),
		.COUT( COUT2 ),
		.SUM( RESULT_SUMSUB[11:8] ),
		.AND_OUT( RESULT_AND[11:8] )
	);
	
	// Multiplexer
	always@(*) begin
		case(CTRL)
			3'b001: // Sum
				begin 
					CIN <= 1'b0;
					RESULT <= RESULT_SUMSUB;
				end
				
			3'b010: // Subtract
				begin
					CIN <= 1'b1;
					RESULT <= RESULT_SUMSUB;
				end
				
			3'b011: // AND
				begin
					CIN <= 1'b0;
					RESULT <= RESULT_AND;
				end
				
			3'b100: // OR
				begin
					CIN <= 1'b0;
					RESULT <= RESULT_OR;
				end
				
			3'b101: // Pass through
				begin
					CIN <= 1'b0;
					RESULT <= A;
				end
				
			default:
				begin
					CIN <= 1'b0;
					RESULT <= A;
				end
		endcase
	end
		
	// zeroflag and negativeflag
	assign ZEROFLAG     = &RESULT[11:0];
	assign NEGATIVEFLAG = RESULT[10];	// As this is a 11 bit computer
	
endmodule 