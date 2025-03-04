module TopModule (
    input logic in,             // 1-bit input signal
    input logic [9:0] state,    // 10-bit input current state, one-hot encoded
    output logic [9:0] next_state, // 10-bit output next state, one-hot encoded
    output logic out1,          // 1-bit output signal
    output logic out2           // 1-bit output signal
);

    always @(*) begin
        // Default next_state and outputs
        next_state = 10'b0000000000;
        out1 = 1'b0;
        out2 = 1'b0;

        // State transition logic
        case (state)
            10'b0000000001: next_state = in ? 10'b0000000010 : 10'b0000000001; // S0
            10'b0000000010: next_state = in ? 10'b0000000100 : 10'b0000000001; // S1
            10'b0000000100: next_state = in ? 10'b0000001000 : 10'b0000000001; // S2
            10'b0000001000: next_state = in ? 10'b0000010000 : 10'b0000000001; // S3
            10'b0000010000: next_state = in ? 10'b0000100000 : 10'b0000000001; // S4
            10'b0000100000: next_state = in ? 10'b0001000000 : 10'b0010000000; // S5
            10'b0001000000: next_state = in ? 10'b0010000000 : 10'b0100000000; // S6
            10'b0010000000: next_state = in ? 10'b0010000000 : 10'b0000000001; // S7
            10'b0100000000: next_state = in ? 10'b0000000010 : 10'b0000000001; // S8
            10'b1000000000: next_state = in ? 10'b0000000010 : 10'b0000000001; // S9
            default: next_state = 10'b0000000001; // Default to S0
        endcase

        // Output logic based on state
        case (state)
            10'b0010000000: {out1, out2} = 2'b01; // S7
            10'b0100000000: {out1, out2} = 2'b10; // S8
            10'b1000000000: {out1, out2} = 2'b11; // S9
            default: {out1, out2} = 2'b00;
        endcase
    end

endmodule