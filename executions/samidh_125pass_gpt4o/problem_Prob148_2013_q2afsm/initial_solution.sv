```verilog
module TopModule (
    input logic clk,
    input logic resetn,
    input logic [2:0] r,
    output logic [2:0] g
);

// State encoding
localparam logic [1:0] STATE_A = 2'd0;
localparam logic [1:0] STATE_B = 2'd1;
localparam logic [1:0] STATE_C = 2'd2;
localparam logic [1:0] STATE_D = 2'd3;

logic [1:0] current_state, next_state;

// State transition logic
always @(posedge clk) begin
    if (!resetn)
        current_state <= STATE_A;
    else
        current_state <= next_state;
end

// Next state logic
always @(*) begin
    case (current_state)
        STATE_A: begin
            if (r[0]) next_state = STATE_B;
            else if (r[1]) next_state = STATE_C;
            else if (r[2]) next_state = STATE_D;
            else next_state = STATE_A;
        end
        STATE_B: begin
            if (r[0]) next_state = STATE_B;
            else next_state = STATE_A;
        end
        STATE_C: begin
            if (r[1]) next_state = STATE_C;
            else next_state = STATE_A;
        end
        STATE_D: begin
            if (r[2]) next_state = STATE_D;
            else next_state = STATE_A;
        end
        default: next_state = STATE_A;
    endcase
end

// Output logic
always @(*) begin
    g = 3'b000; // default
    case (current_state)
        STATE_B: g[0] = 1'b1;
        STATE_C: g[1] = 1'b1;
        STATE_D: g[2] = 1'b1;
    endcase
end

endmodule
```