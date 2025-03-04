module TopModule (
    input logic clk,            // Clock signal, presumed to be positive edge-triggered
    input logic rst_n,          // Active-low synchronous reset
    input logic x,              // Single-bit input
    input logic [2:0] y,        // 3-bit input vector (y[2] is the MSB, y[0] is the LSB)
    output logic Y0,            // Single-bit output, corresponds to the LSB of next state Y[0]
    output logic z              // Single-bit output
);

    logic [2:0] state, next_state;

    // State transition logic
    always_ff @(posedge clk) begin
        if (!rst_n) begin
            state <= 3'b000; // Reset state
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and output logic
    always_comb begin
        case (state)
            3'b000: begin
                next_state = (x == 1'b0) ? 3'b000 : 3'b001;
                z = 1'b0;
            end
            3'b001: begin
                next_state = (x == 1'b0) ? 3'b001 : 3'b100;
                z = 1'b0;
            end
            3'b010: begin
                next_state = (x == 1'b0) ? 3'b010 : 3'b001;
                z = 1'b0;
            end
            3'b011: begin
                next_state = (x == 1'b0) ? 3'b001 : 3'b010;
                z = 1'b1;
            end
            3'b100: begin
                next_state = (x == 1'b0) ? 3'b011 : 3'b100;
                z = 1'b1;
            end
            default: begin
                next_state = 3'b000;
                z = 1'b0;
            end
        endcase
    end

    // Output Y0 logic
    assign Y0 = next_state[0];

endmodule