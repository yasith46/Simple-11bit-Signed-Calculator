module alu(
		input [31:0] A,
		input [31:0] B,
		input [ 2:0] CTRL,
	
		output [31:0] RESULT,
		output ZEROFLAG, NEGATIVEFLAG
	);
	
	
	wire CIN,COUT0,COUT1,COUT2,COUT3,COUT4,COUT5,COUT6,COUT7;
	wire [31:0] B_INT;
	
	
	// Logic for subtraction 
	assign CIN = 
		(CTRL == 3'b000) ? 1'b0 :
		(CTRL == 3'b001) ? 1'b1 :
		1'bx;
		
	assign B_INT = B ^ {8{CIN}};
	
	
	// Adders and subtractors	
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
	
	cla cla4 (
		.A( A[19:16] ),
		.B( B_INT[19:16] ),
		.CIN( COUT3 ),
		.COUT( COUT4 ),
		.SUM( RESULT[19:16] )
	);
	
	cla cla5 (
		.A( A[23:20] ),
		.B( B_INT[23:20] ),
		.CIN( COUT4 ),
		.COUT( COUT5 ),
		.SUM( RESULT[23:20] )
	);
	
	cla cla6 (
		.A( A[27:24] ),
		.B( B_INT[27:24] ),
		.CIN( COUT5 ),
		.COUT( COUT6 ),
		.SUM( RESULT[27:24] )
	);
	
	cla cla7 (
		.A( A[31:28] ),
		.B( B_INT[31:28] ),
		.CIN( COUT6 ),
		.COUT( COUT7 ),
		.SUM( RESULT[31:28] )
	);
	
endmodule 