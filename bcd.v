module bcd(
	input  [10:0] BIN,
	output reg [15:0] BCD
	);
	
	integer i;
	reg [10:0] BIN_INT;

	always@(BIN) begin
		// Coversion of 2's complement to Absolute||
		if (BIN[10] == 1'b1) begin
			BIN_INT <= BIN ^ {11{1'b1}} + 1'b1;
		end else begin
			BIN_INT <= BIN;
		end
		
		// Using the Dibble Dabble algorithm
		BCD = 0;
		for (i=0; i<10; i=i+1) begin
			if (BCD[ 3: 0] >= 5) BCD[ 3: 0] = BCD[ 3: 0] + 4'b0011;
			if (BCD[ 7: 4] >= 5) BCD[ 7: 4] = BCD[ 7: 4] + 4'b0011;
			if (BCD[11: 8] >= 5) BCD[11: 8] = BCD[11: 8] + 4'b0011;
			if (BCD[15:12] >= 5) BCD[15:12] = BCD[15:12] + 4'b0011;
			BCD = {BCD[14:0],BIN_INT[9-i]};
		end
	end
endmodule 