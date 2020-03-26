 //-----------------------------------------------------
 // Design Name : memory_scheme_design producing 256 byte memory
 // File Name   : memory_scheme_design.v
 // Function    : 256 bytes of memory 4 Groups of 8 chips
 // Coder       : Ivan Eloff
 //-----------------------------------------------------
 module memory_scheme_design (
 m_address     , //  8 bit Address Input
 m_data        , //  8 bit Memory Value
 m_chip_enable , //  Enable memory for inout
 m_write_enable, //  1 for Write 0 for Read
 m_out_enable  , //  Output enabled
 );
 
 
 //--------------Input Ports----------------------- 
 input [7:0] m_address;
 input m_chip_enable ; 
 input m_write_enable; 
 input m_out_enable  ; 
  
 //--------------Inout Ports-----------------------
 inout [7:0] m_data; 
 
 //--------------Internal variables----------------
 reg [7:0] bits_out; 
 reg [7:0] memory;
 reg [3:0] group_select;
 
 // Tri-State Buffer control 
 assign m_data = (m_chip_enable && m_out_enable &&  ! m_write_enable) ? bits_out : 8'bz; 
 
 // Write Bits 
 always @ (m_address or m_data or m_chip_enable or m_write_enable)
 begin : MEM_WRITE
    if ( m_chip_enable && m_write_enable ) begin
		 case (m_address[7:6])
			 2'b00 : group_select = 4'b0001;
			 2'b01 : group_select = 4'b0010;
			 2'b10 : group_select = 4'b0100;
			 2'b11 : group_select = 4'b1000;
		 endcase
       memory = m_data;
    end
 end
 
 // Read Bits 
 always @ (m_address or m_chip_enable or m_write_enable or m_out_enable)
 begin : MEM_READ
     if (m_chip_enable &&  ! m_write_enable && m_out_enable)  begin
		 case (m_address[7:6])
			 2'b00 : group_select = 4'b0001;
			 2'b01 : group_select = 4'b0010;
			 2'b10 : group_select = 4'b0100;
			 2'b11 : group_select = 4'b1000;
		 endcase
		 bits_out = memory;
     end
 end
 
 memory_group A (
 .g_address     (m_address), 
 .data_bits     (memory), 
 .g_chip_enable (group_select[0]), 
 .g_write_enable(m_write_enable), 
 .g_out_enable  (m_out_enable),
 );
 
  memory_group B (
 .g_address     (m_address), 
 .data_bits     (memory), 
 .g_chip_enable (group_select[1]), 
 .g_write_enable(m_write_enable), 
 .g_out_enable  (m_out_enable),
 );
 
  memory_group C (
 .g_address     (m_address), 
 .data_bits     (memory), 
 .g_chip_enable (group_select[2]), 
 .g_write_enable(m_write_enable), 
 .g_out_enable  (m_out_enable),
 );
 
  memory_group D (
 .g_address     (m_address), 
 .data_bits     (memory), 
 .g_chip_enable (group_select[3]), 
 .g_write_enable(m_write_enable), 
 .g_out_enable  (m_out_enable),
 );
 
 
 endmodule