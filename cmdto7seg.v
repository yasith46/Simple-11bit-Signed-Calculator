module cmdto7seg(
	input  [2:0] CMD,
	output reg [13:0] OUT
	);
	
	always@(CMD) begin
		case (CMD)
			3'b000:  OUT <= {7'b1000111,7'b0100001}; // Ld
			3'b001:  OUT <= {7'b0001000,7'b0100001}; // Ad
			3'b010:  OUT <= {7'b0010010,7'b1100011}; // Su				
			3'b011:  OUT <= {7'b0001000,7'b0101011}; // An
			3'b100:  OUT <= {7'b1000000,7'b0101111}; // Or
			3'b101:  OUT <= {7'b0010010,7'b0001011}; // Sh 
			default: OUT <= {7'b0111111,7'b0111111}; // --
		endcase
	end
endmodule 