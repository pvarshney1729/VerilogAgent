module TopModule (
    input logic clk,
    input logic reset,
    output logic [3:0] state
);

    // One-hot state representation
    logic [3:0] current_state, next_state;

    // State encoding
    localparam S0 = 4'b0001;
    localparam S1 = 4'b0010;
    localparam S2 = 4'b0100;
    localparam S3 = 4'b1000;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= 4'b0000; // Initialize to zero
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S0;
            default: next_state = 4'b0000; // Default case
        endcase
    end

    // Output state
    assign state = current_state;

endmodule