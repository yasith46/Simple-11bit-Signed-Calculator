module cla (
		input  [3:0] A, 
		input  [3:0] B, 
		input  CIN,
		output COUT,
		output [3:0] SUM,
		output [3:0] AND_OUT
	);
	
	
	wire [3:0] COUT_INT;
	
	// P and G
	wire [3:0] P, G;
	assign P = A ^ B;
	assign G = A & B;
	
	assign AND_OUT = G;
	
	
	// CLA Logic
	// COUT[0]
	wire cout0_w0;
	and cout0_and0 (cout0_w0, P[0], CIN);
	or  cout0_or0  (COUT_INT[0],  G[0], cout0_w0);
	
	// COUT[1]
	wire cout1_w0, cout1_w1;
	and cout1_and0 (cout1_w0, P[0], P[1], CIN);
	and cout1_and1 (cout1_w1, P[1], G[0]);
	or  cout1_or0  (COUT_INT[1],  G[1], cout1_w0, cout1_w1);
	
	// COUt[2]
	wire cout2_w0, cout2_w1, cout2_w2;
	and cout2_and0 (cout2_w0, P[0], P[1], P[2], CIN);
	and cout2_and1 (cout2_w1, P[1], P[2], G[0]);
	and cout2_and2 (cout2_w2, P[2], G[1]);
	or  cout2_or0  (COUT_INT[2],  G[2], cout2_w0, cout2_w1, cout2_w2);
	
	// COUT[3]
	wire cout3_w0, cout3_w1, cout3_w2, cout3_w3;
	and cout3_and0 (cout3_w0, P[0], P[1], P[2], P[3], CIN);
	and cout3_and1 (cout3_w1, P[1], P[2], P[3], G[0]);
	and cout3_and2 (cout3_w2, P[2], P[3], G[1]);
	and cout3_and3 (cout3_w3, P[3], G[2]);
	or  cout3_or0  (COUT_INT[3],  G[3], cout3_w0, cout3_w1, cout3_w2, cout3_w3);
	
	// Output
	assign COUT = COUT_INT[3];
	
	
	// Adder Logic
	xor adder_xor0 (SUM[0], P[0], CIN);
	xor adder_xor1 (SUM[1], P[1], COUT_INT[0]);
	xor adder_xor2 (SUM[2], P[2], COUT_INT[1]);
	xor adder_xor3 (SUM[3], P[3], COUT_INT[2]);
endmodule 