module cacheSim(input[14:0] adr,input clk,rst,output[12:0] HitRate);
  
  wire memRead, memWrite, cacheWrite, valid, hit;
  wire[31:0] CacheToMem0, CacheToMem1, CacheToMem2, CacheToMem3;
  wire[31:0] MemToCache0, MemToCache1, MemToCache2, MemToCache3;
  wire[2:0] tagOut;
  
  Memory mem(.clk(clk), .memRead(memRead), .memWrite(memWrite), .rst(rst), .address(adr), 
       .writeData0(CacheToMem0), .writeData1(CacheToMem1), .writeData2(CacheToMem2), .writeData3(CacheToMem3),
       .Data0(MemToCache0), .Data1(MemToCache1), .Data2(MemToCache2), .Data3(MemToCache3));
       
  Cache cache(.clk(clk), .rst(rst), .cacheWrite(cacheWrite), .indx(adr[11:2]), .TagIn(adr[14:12]), 
        .cacheWriteData0(MemToCache0), .cacheWriteData1(MemToCache1), .cacheWriteData2(MemToCache2), .cacheWriteData3(MemToCache3),
	      .valid(valid), .TagOut(tagOut), .writeData0(CacheToMem0), .writeData1(CacheToMem1), .writeData2(CacheToMem2), .writeData3(CacheToMem3));
	
	assign hit = (tagOut == adr[14:12]) & valid;
	assign cacheWrite = ~hit;
	assign memRead = ~hit;
	assign memWrite = 1'b0;
	
  Counter  co(.clk(clk), .rst(rst), .CEn(hit), .count(HitRate));  
endmodule
