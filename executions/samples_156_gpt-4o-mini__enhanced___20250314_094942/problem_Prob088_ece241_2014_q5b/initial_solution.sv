module TopModule (
    input logic clk,          // Clock signal (1-bit)
    input logic areset,      // Asynchronous active-high reset (1-bit)
    input logic x,           // Input signal (1-bit)
    output logic z           // Output signal (1-bit)
);

    // State definitions using one-hot encoding
    logic [1:0] state, next_state;

    // State encoding
    localparam STATE_A = 2'b01;
    localparam STATE_B = 2'b10;

    // Asynchronous reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= STATE_A;
            z <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state and output
    always @(*) begin
        case (state)
            STATE_A: begin
                if (x) begin
                    next_state = STATE_B;
                    z = 1'b1;
                end else begin
                    next_state = STATE_A;
                    z = 1'b0;
                end
            end
            STATE_B: begin
                next_state = STATE_B; // Remain in B
                z = x ? 1'b0 : 1'b1;  // z = 1 if x = 0, z = 0 if x = 1
            end
            default: begin
                next_state = STATE_A; // Default to state A
                z = 1'b0;
            end
        endcase
    end

endmodule