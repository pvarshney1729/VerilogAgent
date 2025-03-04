module TopModule (
    input logic clk,               // Clock signal for synchronous operation
    input logic rst_n,             // Active-low asynchronous reset signal
    input logic in,                // 1-bit input signal, active high
    input logic [9:0] state,       // 10-bit one-hot encoded current state
    output logic [9:0] next_state, // 10-bit one-hot encoded next state
    output logic out1,             // 1-bit output signal for state machine
    output logic out2              // 1-bit output signal for state machine
);

    // State transition logic
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            next_state <= 10'b0000000001; // Initialize to state S0
        end else begin
            case (state)
                10'b0000000001: next_state <= in ? 10'b0000000010 : 10'b0000000001; // S0
                10'b0000000010: next_state <= in ? 10'b0000000100 : 10'b0000000010; // S1
                10'b0000000100: next_state <= in ? 10'b0000001000 : 10'b0000000100; // S2
                10'b0000001000: next_state <= in ? 10'b0000010000 : 10'b0000001000; // S3
                10'b0000010000: next_state <= in ? 10'b0000100000 : 10'b0000010000; // S4
                10'b0000100000: next_state <= in ? 10'b0001000000 : 10'b0000100000; // S5
                10'b0001000000: next_state <= in ? 10'b0010000000 : 10'b0001000000; // S6
                10'b0010000000: next_state <= in ? 10'b0100000000 : 10'b0010000000; // S7
                10'b0100000000: next_state <= in ? 10'b1000000000 : 10'b0100000000; // S8
                10'b1000000000: next_state <= in ? 10'b0000000001 : 10'b1000000000; // S9
                default: next_state <= 10'b0000000001; // Undefined state, reset to S0
            endcase
        end
    end

    // Output logic
    always_comb begin
        out1 = (state == 10'b0100000000) || (state == 10'b1000000000); // S8, S9
        out2 = (state == 10'b0010000000) || (state == 10'b1000000000); // S7, S9
    end

endmodule