module TopModule (
  input wire clk,         
  input wire x,           
  input wire [2:0] y,     
  input wire reset_n,     // Asynchronous active-low reset
  output reg Y0,          
  output reg z            
);

  reg [2:0] next_state;

  always @(*) begin
    case (y)
      3'b000: next_state = (x == 1'b0) ? 3'b000 : 3'b001;
      3'b001: next_state = (x == 1'b0) ? 3'b001 : 3'b100;
      3'b010: next_state = (x == 1'b0) ? 3'b010 : 3'b001;
      3'b011: next_state = (x == 1'b0) ? 3'b001 : 3'b010;
      3'b100: next_state = (x == 1'b0) ? 3'b011 : 3'b100;
      default: next_state = 3'b000; // Safe state
    endcase
  end

  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      Y0 <= 1'b0;
      z <= 1'b0;
    end else begin
      Y0 <= next_state[0];
      z <= (y == 3'b011 && x == 1'b1) || (y == 3'b100) ? 1'b1 : 1'b0;
    end
  end

endmodule