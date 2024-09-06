module bcdto7seg(
	input  [3:0] IN,
	output reg [6:0] OUT
	);
	
	always@(IN) begin
		case (IN)
			4'b0000: OUT <= 7'b1000000; // 0
			4'b0001: OUT <= 7'b1111001; // 1
			4'b0010: OUT <= 7'b0100100; // 2
			4'b0011: OUT <= 7'b0110000; // 3
			4'b0100: OUT <= 7'b0011001; // 4
			4'b0101: OUT <= 7'b0010010; // 5
			4'b0110: OUT <= 7'b0000010; // 6
			4'b0111: OUT <= 7'b1111000; // 7
			4'b1000: OUT <= 7'b0000000; // 8
			4'b1001: OUT <= 7'b0010000; // 9
			default: OUT <= 7'b1111111; // OFF
		endcase
	end
endmodule 