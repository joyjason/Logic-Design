module simulate() ;

reg clk, reset ;
reg [6:0] coin ;
wire [6:0] refund ;
reg [2:0]  drink_choose ;
wire [2:0] give ; 
wire[6:0] total_coin ;

AutoVendor autoVendor( clk, coin, reset, drink_choose, give, refund, total_coin ) ;

initial clk = 1'b1;
initial coin = 0;
initial drink_choose = 3'b000;
always #10 clk = ~clk;

always @ ( reset )
  if ( reset )
  begin
    coin = 0;
    reset = 0;
    drink_choose = 3'b000;
end
initial
begin
 // 000nothing changed 還是討厭下雨天 001tea 010coke 011coffee 100 milk;
 /*coin = 0;
#10 coin = 5;
 #10 coin = 5;
 #10 coin = 1;
 #10 coin = 1;
 #10 coin = 10;
 #10 coin = 0;
 #10 drink_choose = 3'b010;
 #30 reset = 1;
  $stop;
 */
/*
#10 coin = 5;
 #10 coin = 5;
 #10 coin = 50;
 #10 coin = 1;
 #10 coin = 10;
 #10 coin = 0;
 #30 reset = 1;
 #10 coin = 1;
 #10 coin = 10;
 #10 coin = 10;
 #10 coin = 0;
 #10 drink_choose = 3'b011;
 #30 reset = 1;
*/
 #10 coin = 10;
 #10 coin = 1;
 #10 coin = 5;
 #5 reset = 1;
 #10 coin = 5;
 #10 coin = 5;
 #10 coin = 1;
 #10 coin = 1;
 #10 coin = 10;
 #10 coin = 0;
 #10 drink_choose = 3'b100;
 #30 reset = 1;
 #10 coin = 10;
 #10 coin = 0;
#10 drink_choose = 3'b001;
 #30 reset = 1;
 #20 coin = 1;
 #10 coin = 1;
 #10 coin = 10;
 #10 coin = 0;
#10 drink_choose = 3'b001;
 #30 reset = 1;
  $stop;
end

endmodule
