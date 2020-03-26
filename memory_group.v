 //-----------------------------------------------------
 // Design Name : memory_group producing 8 bit MBR
 // File Name   : memory_group.v
 // Function    : a group op 8 8*8*1 memory chips
 // Coder       : Ivan Eloff
 //-----------------------------------------------------
 module memory_group (
 g_address     , //  8 bit Address Input
 data_bits     , //  8 bit Memory Value
 g_chip_enable , //  Enable chip for inout
 g_write_enable, //  1 for Write 0 for Read
 g_out_enable  , //  Output enabled
 );
 
 
 //--------------Input Ports----------------------- 
 input [7:0] g_address;
 input g_chip_enable ; 
 input g_write_enable; 
 input g_out_enable  ; 
  
 //--------------Inout Ports-----------------------
 inout [7:0] data_bits; 
 
 //--------------Internal variables----------------
 reg [7:0] bits_out; 
 reg [7:0] memory;
 
 // Tri-State Buffer control 
 assign data_bits = (g_chip_enable && g_out_enable &&  ! g_write_enable) ? bits_out : 8'bz; 
 
 // Write Bits 
 always @ (g_address or data_bits or g_chip_enable or g_write_enable)
 begin : BITS_WRITE
    if ( g_chip_enable && g_write_enable ) begin
        memory = data_bits;
    end
 end
 
 // Read Bits 
 always @ (g_address or g_chip_enable or g_write_enable or g_out_enable)
 begin : BITS_READ
     if (g_chip_enable &&  ! g_write_enable && g_out_enable)  begin
          bits_out = memory;
     end
 end
 
 memory_chip Chip0 (
 .address     (g_address), 
 .data_bit    (memory[0]), 
 .chip_enable (g_chip_enable), 
 .write_enable(g_write_enable), 
 .out_enable  (g_out_enable),
 );
 
  memory_chip Chip1 (
 .address     (g_address), 
 .data_bit    (memory[1]), 
 .chip_enable (g_chip_enable), 
 .write_enable(g_write_enable), 
 .out_enable  (g_out_enable),
 );
 
  memory_chip Chip2 (
 .address     (g_address), 
 .data_bit    (memory[2]), 
 .chip_enable (g_chip_enable), 
 .write_enable(g_write_enable), 
 .out_enable  (g_out_enable),
 );
 
  memory_chip Chip3 (
 .address     (g_address), 
 .data_bit    (memory[3]), 
 .chip_enable (g_chip_enable), 
 .write_enable(g_write_enable), 
 .out_enable  (g_out_enable),
 );
 
  memory_chip Chip4 (
 .address     (g_address), 
 .data_bit    (memory[4]), 
 .chip_enable (g_chip_enable), 
 .write_enable(g_write_enable), 
 .out_enable  (g_out_enable),
 );
 
  memory_chip Chip5 (
 .address     (g_address), 
 .data_bit    (memory[5]), 
 .chip_enable (g_chip_enable), 
 .write_enable(g_write_enable), 
 .out_enable  (g_out_enable),
 );
 
  memory_chip Chip6 (
 .address     (g_address), 
 .data_bit    (memory[6]), 
 .chip_enable (g_chip_enable), 
 .write_enable(g_write_enable), 
 .out_enable  (g_out_enable),
 );
 
  memory_chip Chip7 (
 .address     (g_address), 
 .data_bit    (memory[7]), 
 .chip_enable (g_chip_enable), 
 .write_enable(g_write_enable), 
 .out_enable  (g_out_enable),
 );
 
 
 endmodule