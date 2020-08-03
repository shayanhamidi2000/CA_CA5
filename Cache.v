module Cache(input clk,rst,cacheWrite,input[9:0] indx,input[2:0] TagIn,input[31:0] cacheWriteData0,input[31:0] cacheWriteData1,input[31:0] cacheWriteData2,input[31:0] cacheWriteData3,
	output valid,output[2:0]TagOut,output[31:0] writeData0,output[31:0] writeData1,output[31:0] writeData2,output[31:0] writeData3);
	
	reg v[0:1023];
	reg[2:0] tag[0:1023];
	reg[31:0] data0[0:1023];
	reg[31:0] data1[0:1023];
	reg[31:0] data2[0:1023];
	reg[31:0] data3[0:1023];
	integer counter;
	
	assign valid = v[indx];
	assign TagOut = tag[indx];
	assign writeData0 = data0[indx];
	assign writeData1 = data1[indx];
	assign writeData2 = data2[indx];
	assign writeData3 = data3[indx];
	always@(posedge clk,posedge rst)begin
		if(rst) begin
			for(counter = 0 ; counter < 1024 ; counter = counter + 1)begin
				v[counter] <= 1'b0;
				tag[counter] <= 3'b000;
				data0[counter] <= 32'b0;
				data1[counter] <= 32'b0;
				data2[counter] <= 32'b0;
				data3[counter] <= 32'b0;
			end
		end
		if(cacheWrite) begin
			v[indx] <= 1'b1;
			tag[indx] <= TagIn;
			data0[indx] <= cacheWriteData0;
			data1[indx] <= cacheWriteData1;
			data2[indx] <= cacheWriteData2;
			data3[indx] <= cacheWriteData3;
		end
	end
endmodule
