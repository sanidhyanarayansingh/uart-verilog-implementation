module uarttransmitter (tx , datain , ready , ipclk );
output reg tx  ;
input [7:0] datain ;
input ipclk , ready ;

reg [7:0] data_temp ;
reg [3:0] bitpos    ;
reg [1:0] state     ;
reg temp ;

parameter idle = 2'b00 , start = 2'b01 , processing = 2'b10 , stop = 2'b11 ;

initial 
  begin
	tx     = 1'bx ;
	state <= idle ;
  end

always @ (posedge ipclk)
 begin
	case(state)
					idle : begin
							if(ready == 1'b1)
								begin
									    	    tx = 1'bx    ;
									    data_temp <= datain  ;
									       bitpos <= 4'b0000 ;
										state <= start   ;
					       			end
						/*	else
								begin
										tx = 1'bz ;
										state <= stop ;
								end */
					       end
				       start : begin
							       	    tx = 1'b0 ;
								state <= processing ;
					       end
				  processing : begin
								if(bitpos == 4'b1000)
										begin
												    tx = 1'b1 ;
												state <= stop ;
										end
								else
										begin
												    tx = data_temp[bitpos] ;
												bitpos = bitpos + 4'b0001  ;
												state <= processing        ;
										end
					       end
					stop : begin
							      tx = 1'b1 ;
							  state <= idle ;
							    
					       end
				     default : begin
							      tx = 1'b1 ;
						          state <= idle ;
							    
					       end
			endcase
	if ( ready == 1'b0 )
		begin
			tx = 1'bx ;
			state <= idle ;
		end

 end 

endmodule

