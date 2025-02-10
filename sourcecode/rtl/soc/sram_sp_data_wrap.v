module sram_sp_data_wrap (
		input 		clk,
		input 		data_req_i,
		input [31:0] 	data_addr_i,
		input 		data_we_i,
		input [3:0] 	data_be_i,
		input [31:0]	data_wdata_i,
		input [1:0]	ds_addr_sel_0,
		output reg [31:0] data_rdata_o
   );

   wire [31:0] data_rdata_i_0;
   wire [31:0] data_rdata_i_1;
   wire [31:0] data_rdata_i_2;
   wire [31:0] data_rdata_i_3;
    

// Fill in your instantiations here
// You must use the name "dccm_ram_0" for the memory instantiation!!!
sram_sp_8192x32_m16_be_wrap 
		dccm_ram_0 (
					.CLK(clk),     
					.CEN(!(data_req_i && !data_addr_i[16] && !data_addr_i[15])), 
					.GWEN(!(data_req_i && data_we_i)),                    
					.BEN(~data_be_i),        
					.A(data_addr_i[14:2]),      
					.D(data_wdata_i),   
					.Q(data_rdata_i_0)                                 
					);

	sram_sp_8192x32_m16_be_wrap 
		dccm_ram_1 (
					.CLK(clk),     
					.CEN(!(data_req_i && !data_addr_i[16] && data_addr_i[15])), 
					.GWEN(!(data_req_i && data_we_i)),                    
					.BEN(~data_be_i),        
					.A(data_addr_i[14:2]),      
					.D(data_wdata_i),   
					.Q(data_rdata_i_1)                                       
					);

	sram_sp_8192x32_m16_be_wrap 
		dccm_ram_2 (
					.CLK(clk),     
					.CEN(!(data_req_i && data_addr_i[16] && !data_addr_i[15])), 
					.GWEN(!(data_req_i && data_we_i)),                    
					.BEN(~data_be_i),        
					.A(data_addr_i[14:2]),      
					.D(data_wdata_i),   
					.Q(data_rdata_i_2)                                       
					);

	sram_sp_8192x32_m16_be_wrap
		dccm_ram_3 (
					.CLK(clk),     
					.CEN(!(data_req_i && data_addr_i[16] && data_addr_i[15])), 
					.GWEN(!(data_req_i && data_we_i)),                    
					.BEN(~data_be_i),        
					.A(data_addr_i[14:2]),      
					.D(data_wdata_i),   
					.Q(data_rdata_i_3)                                       
					);
				
	assign data_rdata_o = ds_addr_sel_0[1] ? 
	(ds_addr_sel_0[0] ? data_rdata_i_0 : data_rdata_i_1) :
	(ds_addr_sel_0[0] ? data_rdata_i_2 : data_rdata_i_3);



endmodule
