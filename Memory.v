module Memory(input clk, memRead, memWrite, rst, input[14:0] address, input[31:0] writeData0, input[31:0] writeData1, input[31:0] writeData2, input[31:0] writeData3,
       output[31:0] Data0, output[31:0] Data1, output[31:0] Data2, output[31:0] Data3);
       
  reg[31:0] mem[0:32767];
  integer counter;
 	initial begin
	#1000
    		$readmemh("./data.hex", mem, 1024);
	end
	
	assign Data0 = memRead ? mem[{address[14:2], 2'b00}] : 32'bZ;
	assign Data1 = memRead ? mem[{address[14:2], 2'b01}] : 32'bZ;
	assign Data2 = memRead ? mem[{address[14:2], 2'b10}] : 32'bZ;
	assign Data3 = memRead ? mem[{address[14:2], 2'b11}] : 32'bZ;
	
	always @(posedge clk , posedge rst)begin
    		if(rst)begin
			 for(counter = 0;counter < 32767;counter = counter + 1)
				  mem[counter] <= 32'b0;
		  end
		if(memWrite)begin
			mem[{address[14:2], 2'b00}] <= writeData0;
			mem[{address[14:2], 2'b01}] <= writeData1;
			mem[{address[14:2], 2'b10}] <= writeData2;
			mem[{address[14:2], 2'b11}] <= writeData3;
		end
	end
endmodule
