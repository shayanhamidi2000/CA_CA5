module Counter(input clk,rst,CEn, output reg [13:0]count);
	always @(posedge clk , posedge rst) begin
		if(rst) count <= 13'b0;
		else if(CEn) count <= count + 1; 
		else count <= count;
	end
endmodule

