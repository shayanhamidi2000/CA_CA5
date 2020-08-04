module TB();
    reg clk,rst;
    reg[14:0] adr = 1024;
    wire[12:0] HitRate;
    cacheSim circuit(.adr(adr) , .clk(clk) , .rst(rst) ,.HitRate(HitRate) );
    initial begin
        rst = 1'b1;
	clk = 1'b0;
	#100
	clk = 1'b1;
	#100
	clk = 1'b0;
	rst = 1'b0;
	repeat(8191) begin
		#200 clk = ~clk;
		adr = adr + 1;
		#200 clk = ~clk;
	end
	#5000
        $stop;
    end
    
endmodule
