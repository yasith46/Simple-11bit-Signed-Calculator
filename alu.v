module alu(
		input [15:0] A,
		input [15:0] B,
		input [ 2:0] CTRL,
	
		output reg [15:0] RESULT,
		output ZEROFLAG, NEGATIVEFLAG
	);
	
	
	wire [15:0] RESULT_AND;
	wire [15:0] RESULT_OR;
	wire [15:0] RESULT_SUMSUB;
	
	// Logic of AND and OR
	assign RESULT_OR = A | B;
	
	
	// Logic for subtraction 
	reg CIN;
	wire COUT0,COUT1,COUT2,COUT3;
	wire [15:0] B_INT;
		
	assign B_INT = B ^ {8{CIN}};
	
	
	
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
	
	cla cla3 (
		.A( A[15:12] ),
		.B( B_INT[15:12] ),
		.CIN( COUT2 ),
		.COUT( COUT3 ),
		.SUM( RESULT_SUMSUB[15:12] ),
		.AND_OUT( RESULT_AND[15:12] )
	);
	
	// Multiplexer
	always@(*) begin
		case(CTRL)
			3'b000:
				begin 
					CIN <= 1'b0;
					RESULT <= RESULT_SUMSUB;
				end
				
			3'b001:
				begin
					CIN <= 1'b1;
					RESULT <= RESULT_SUMSUB;
				end
				
			3'b010:
				begin
					CIN <= 1'b0;
					RESULT <= RESULT_AND;
				end
				
			3'b011:
				begin
					CIN <= 1'b0;
					RESULT <= RESULT_OR;
				end
				
			3'b100:
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
	assign ZEROFLAG     = &RESULT[15:0];
	assign NEGATIVEFLAG = RESULT[15];
	
endmodule 