module alu(
	input [15:0] A,
	input [15:0] B,
	input [2:0] CTRL,
	
	output [15:0] RESULT,
	output ZEROFLAG, NEGATIVEFLAG
	);
	
	wire CIN,COUT0,COUT1,COUT2,COUT3;
	wire [15:0] B_INT;
	
	assign CIN = 
		(CTRL == 3'b000) ? 1'b0 :
		(CTRL == 3'b001) ? 1'b1 :
		1'bx;
		
	assign B_INT = B ^ {8{CIN}};
	
	cla cla0 (
		.A( A[3:0] ),
		.B( B_INT[3:0] ),
		.CIN( CIN ),
		.COUT( COUT0 ),
		.SUM( RESULT[3:0] )
	);
	
	cla cla1 (
		.A( A[7:4] ),
		.B( B_INT[7:4] ),
		.CIN( COUT0 ),
		.COUT( COUT1 ),
		.SUM( RESULT[7:4] )
	);
	
	cla cla2 (
		.A( A[11:8] ),
		.B( B_INT[11:8] ),
		.CIN( COUT1 ),
		.COUT( COUT2 ),
		.SUM( RESULT[11:8] )
	);
	
	cla cla3 (
		.A( A[15:12] ),
		.B( B_INT[15:12] ),
		.CIN( COUT2 ),
		.COUT( COUT3 ),
		.SUM( RESULT[15:12] )
	);
	
endmodule 