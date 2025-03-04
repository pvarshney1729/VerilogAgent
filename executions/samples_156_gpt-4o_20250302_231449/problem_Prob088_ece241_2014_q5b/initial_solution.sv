module TopModule (
    input  wire clk,       // Positive-edge triggered clock
    input  wire areset,    // Asynchronous, active-high reset
    input  wire x,         // Input signal
    output reg  z          // Output signal
);

reg [1:0] state, next_state;

// State encoding
localparam STATE_A = 2'b01;
localparam STATE_B = 2'b10;

// State transition logic
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= STATE_A; // Reset to state A
        z <= 0;
    end else begin
        state <= next_state;
    end
end

// Next state and output logic
always @(*) begin
    case (state)
        STATE_A: begin
            if (x == 0) begin
                next_state = STATE_A; // Stay in state A
                z = 0;
            end else begin
                next_state = STATE_B; // Move to state B
                z = 1;
            end
        end
        STATE_B: begin
            if (x == 0) begin
                next_state = STATE_B; // Stay in state B
                z = 1;
            end else begin
                next_state = STATE_B; // Stay in state B
                z = 0;
            end
        end
        default: begin
            next_state = STATE_A; // Default to state A
            z = 0;
        end
    endcase
end

endmodule