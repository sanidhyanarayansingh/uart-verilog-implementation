module uartreceiver (ready , data , rx , ipclk );
output reg ready ;
output reg [7:0] data ;
input rx , ipclk ;

reg [3:0] bitpos ;
reg [1:0] state ;
reg [9:0] temp_data = 0 ;
reg [7:0] data1 ;

parameter idle = 2'b00 , start = 2'b01 , processing = 2'b10 , stop = 2'b11 ;

initial 
  begin
	ready = 1'bx ;
	state <= idle ;
  end

always @ (posedge ipclk)
 begin
		case(state)
			idle : begin
					state  <= start   ;
					 ready  = 1'b0    ;
					bitpos <= 4'b0000 ;
					   data = 8'bx ;
			       end
		       start : begin
					temp_data[0] = rx ;
					if(temp_data == 0)
						begin
							state <= processing ;
							bitpos = bitpos + 4'b0001 ;
						end
					else
							state <= start ;
			       end
		  processing : begin
					temp_data[bitpos] = rx    ;
					bitpos = bitpos + 4'b0001 ;
					if(temp_data[9] == 1 )
						begin
							state <= stop ;
						end
					else
						begin
						        data1[bitpos-2]  = temp_data[bitpos-1];
						                state  <= processing ;
						end
			       end 		
    		       stop  : begin
				  	   ready = 1'b1 ;
					   data <= data1 ;
					  state <= idle ;
		       	       end
    		     default : begin
					 ready = 1'b0 ;
	          		        state <= idle ;
			       end
		endcase
 end

endmodule
