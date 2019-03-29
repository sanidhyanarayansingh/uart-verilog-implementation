module baud_gen ( count , ipclk , selection );
output integer count ;
input [1:0] selection ;
input ipclk ;

parameter ipclk_freq = 50000000 , baud_rate1 = 4800 , baud_rate2 = 9600 ,  baud_rate3 = 38400 , baud_rate4 = 19200 ;

initial
	count = 0 ; // value of UxBrg = [(freq/(16*Baud_rate)) - 1]  

always @(posedge ipclk)
 	begin
		case(selection)
			2'b00 : count = 651;
			2'b01 : count = 325;
			2'b10 : count = 163;
			2'b11 : count = 81;

		endcase
	end
endmodule
