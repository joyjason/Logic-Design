module AutoVendor( clk, coin, reset, drink_choose, give, refund, total_coin ) ;



input clk, reset ;
input [6:0] coin ;
input [2:0] drink_choose ;
output [2:0] give ;
output [6:0] refund ;
output [6:0] total_coin ;

reg [1:0] tea, coke, coffee, milk ;

parameter S0 = 3'd0,
	  S1 = 3'd1,
	  S2 = 3'd2,
	  S3 = 3'd3 ;
	  
reg [2:0] state ;
reg [2:0] next_state ;
reg [6:0] total_coin ;




reg [6:0] refund ;

reg [3:0] give ;

initial 
begin

    total_coin = 0 ;
    tea = 1'b0 ;
    coke = 1'b0 ;
    coffee = 1'b0 ;
    milk = 1'b0 ;
    refund = 0 ;
    give = 0 ;
	state = S0 ;
	next_state = S0;
end

always @ ( clk )//加錢
begin
	total_coin = total_coin + coin;
        //next_state = S1;

end

always @ ( clk or reset )
  if ( reset )
  begin

    tea = 1'b0 ;
    coke = 1'b0 ;
    coffee = 1'b0 ;
    milk = 1'b0 ;
    $display( "exchange ", total_coin, " dollars " );
    total_coin = 0;
    refund = 0 ;
    give = 0 ;
    state = S0 ;
    next_state = S0;
  end
  else
    state = next_state ;

always @ ( state or total_coin or tea or coke or coffee or milk or clk )//改狀態用
begin
       case ( state )
        S0 :       
        begin
            if ( total_coin > 0 ) next_state = S1 ;
            else next_state = S0 ;

        end
        S1 :
        begin
			if ( drink_choose == 3'b001 || drink_choose == 3'b010 || drink_choose == 3'b011 || drink_choose == 3'b100 )
                           if( drink_choose == 3'b001 && tea == 1 ) next_state = S2;
                           else if( drink_choose == 3'b010 && coke == 1 ) next_state = S2;
			   else if( drink_choose == 3'b011 && coffee == 1 ) next_state = S2;
                           else if( drink_choose == 3'b100 && milk == 1 ) next_state = S2;
                           else next_state = S1;
			else next_state = S1 ;
        end	  
		
        S2 :       
        begin
            next_state = S3 ;
        end		
		
		S3 :
		begin
		    next_state = S0 ; 
		end
		endcase
end

always @ ( state or total_coin or drink_choose)//找零用
begin

case ( state )
    S0 :
    begin
         if ( total_coin >= 25 ) $display( "coin ", coin, "	total " , total_coin, " dollar	tea | coke | coffee | milk " );
         else if ( total_coin >= 20 ) $display( "coin ", coin, "	total " , total_coin, " dollar	tea | coke | coffee" );
         else if ( total_coin >= 15 ) $display( "coin ", coin, "	total " , total_coin, " dollar	tea | coke " );
         else if ( total_coin >= 10 ) $display( "coin ", coin, "	total " , total_coin, " dollar	tea" );
         else if ( total_coin > 0 ) $display( "coin ", coin, "	total " , total_coin, " dollar" );
    end
    S1 :  //顯示可以買的東西
    begin
        if ( total_coin >= 10 ) tea = 1 ;
        if ( total_coin >= 15 ) coke = 1;
        if ( total_coin >= 20 ) coffee = 1 ;
        if ( total_coin >= 25 ) milk = 1 ;
	if ( milk == 1 ) $display( "coin ", coin, "	total " , total_coin, " dollar	tea | coke | coffee | milk " );
        else if ( coffee == 1 ) $display( "coin ", coin, "	total " , total_coin, " dollar	tea | coke | coffee" );
        else if ( coke == 1 ) $display( "coin ", coin, "	total " , total_coin, " dollar	tea | coke " );
        else if ( tea == 1 ) $display( "coin ", coin, "	total " , total_coin, " dollar	tea" );
        else if ( total_coin > 0 ) $display( "coin ", coin, "	total " , total_coin, " dollar" );
    end

    S2 : //給東西
    begin
        give = drink_choose ;
        if ( drink_choose == 3'b001 ) $display( "tea out" );
	else if ( drink_choose == 3'b010 ) $display( "coke out" );
	else if ( drink_choose == 3'b011 ) $display( "coffee out" );
	else if ( drink_choose == 3'b100 ) $display( "milk out" );
    end	
	
    S3 :
    begin // 找零
	
    if ( drink_choose == 3'b001 ) total_coin = total_coin - 10;
	else if ( drink_choose == 3'b010 ) total_coin = total_coin -15;
	else if ( drink_choose == 3'b011 ) total_coin = total_coin -20;
	else if ( drink_choose == 3'b100 ) total_coin = total_coin -25;
	
    refund = total_coin;	
	$display( "exchange ", refund, " dollars " );
        total_coin = 0;
        refund = 0;
    end	
	
endcase
end





endmodule

