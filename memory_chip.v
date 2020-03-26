 //-----------------------------------------------------
 // Design Name : memory_chip 8*8*1
 // File Name   : memory_chip.v
 // Function    : a single 8*8*1 memory chip
 // Coder       : Ivan Eloff
 //-----------------------------------------------------
 module memory_chip (
 address     , //  8 bit Address Input
 data_bit    , //  1 bit Memory Value
 chip_enable , //  Enable chip for inout
 write_enable, //  1 for Write 0 for Read
 out_enable  , //  Output enabled
 );
 
 
 //--------------Input Ports----------------------- 
 input [7:0] address;
 input chip_enable ; 
 input write_enable; 
 input out_enable  ; 
  
 //--------------Inout Ports-----------------------
 inout data_bit; 
 
 //--------------Internal variables----------------
 reg bit_out; 
 reg data_64_bits [0:7] [0:7];
 integer row;
 integer col;
 
 // Tri-State Buffer control 
 assign data_bit = (chip_enable && out_enable &&  ! write_enable) ? bit_out : 1'bz; 
 
 // Write Bit 
 always @ (address or data_bit or chip_enable or write_enable)
 begin : BIT_WRITE
	 row = address[0 +: 3];
	 col = address[3 +: 3];
    if ( chip_enable && write_enable ) begin
        data_64_bits[row][col] = data_bit;
    end
 end
 
 // Read Bit 
 always @ (address or chip_enable or write_enable or out_enable)
 begin : BIT_READ
	  row = address[0 +: 3];
	  col = address[3 +: 3];
     if (chip_enable &&  ! write_enable && out_enable)  begin
          bit_out = data_64_bits[row][col];
     end
 end
 
 endmodule