`include "uart_baud.v"
`include "uarttransmitter.v"
`include "uartreceiver.v"
module uart ( tx , datain , ipclk , readyop , data , selection , readyip ) ;
output tx , readyop ;
output [7:0] data ;
input ipclk ;
input [7:0] datain ;
input [1:0] selection ;
input readyip ;
baud_gen        x1 ( .count(count) , .ipclk(ipclk) , .selection(selection) );
uarttransmitter x2 (.tx(tx) , .datain(datain) , .ready(readyip) , .ipclk(ipclk) );
uartreceiver    x3 (.ready(readyop) , .data(data) , .rx(tx) , .ipclk(ipclk) );

endmodule 

module uarttb() ;
wire tx , readyop ;
wire [7:0] data ;
reg ipclk ;
reg [7:0] datain ;
reg [1:0] selection ;
reg readyip ;
uart u1 ( .tx(tx) , .datain(datain) , .ipclk(ipclk) , .readyop(readyop) , .data(data) , .selection(selection) , .readyip(readyip)) ;
/*
initial 
 begin
	$monitor ("time=%g,dataout=%b",$time,data);
 end
*/
initial 
	ipclk = 0 ;

always 
	#20 ipclk = ~ipclk ;

initial
 begin 
	datain    = 8'b10101010;
  	selection = 2'b01;
	readyip   = 1'b1 ;	
 end

initial 
 #500 readyip = 1'b0 ;

endmodule


