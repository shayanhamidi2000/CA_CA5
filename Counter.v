module Counter(input clk,rst,CEn, output reg [12:0]count);
	always @(posedge clk , posedge rst) begin
		if(rst) count <= 13'b0;
		else if(CEn) count <= count + 1; 
		else count <= count;
	end
endmodule

