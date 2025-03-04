module TopModule (
    input logic clk,           // Clock signal for synchronizing state transitions
    input logic rst_n,         // Active low reset signal
    input logic in,            // 1-bit input signal
    input logic [9:0] state,   // Current state in one-hot encoding
    output logic [9:0] next_state, // Next state in one-hot encoding
    output logic out1,          // Output 1
    output logic out2           // Output 2
);

always @(*) begin
    // Default values
    next_state = 10'b0000000000;
    out1 = 1'b0;
    out2 = 1'b0;

    // State transition logic
    case (state)
        10'b0000000001: next_state = (in) ? 10'b0000000010 : 10'b0000000001; // S0
        10'b0000000010: next_state = (in) ? 10'b0000000100 : 10'b0000000001; // S1
        10'b0000000100: next_state = (in) ? 10'b0000001000 : 10'b0000000001; // S2
        10'b0000001000: next_state = (in) ? 10'b0000010000 : 10'b0000000001; // S3
        10'b0000010000: next_state = (in) ? 10'b0000100000 : 10'b0000000001; // S4
        10'b0000100000: next_state = (in) ? 10'b0001000000 : 10'b0001000000; // S5
        10'b0001000000: next_state = (in) ? 10'b0010000000 : 10'b0100000000; // S6
        10'b0010000000: begin
            next_state = (in) ? 10'b0010000000 : 10'b0000000001; // S7
            out2 = 1'b1;
        end
        10'b0100000000: begin
            next_state = (in) ? 10'b0000000010 : 10'b0000000001; // S8
            out1 = 1'b1;
        end
        10'b1000000000: begin
            next_state = (in) ? 10'b0000000010 : 10'b0000000001; // S9
            out1 = 1'b1;
            out2 = 1'b1;
        end
        default: next_state = 10'b0000000001; // Undefined state handling
    endcase
end

endmodule