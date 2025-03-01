module TopModule (
    input logic in,               // 1-bit input
    input logic [9:0] state,      // 10-bit one-hot encoded current state
    output logic [9:0] next_state, // 10-bit one-hot encoded next state
    output logic out1,             // 1-bit output
    output logic out2              // 1-bit output
);

    always @(*) begin
        // Default outputs
        out1 = 1'b0;
        out2 = 1'b0;
        next_state = 10'b0000000001; // Default to S0

        // Check for valid one-hot state
        if (^state === 1'b1) begin
            case (state)
                10'b0000000001: next_state = in ? 10'b0000000010 : 10'b0000000001; // S0
                10'b0000000010: next_state = in ? 10'b0000000100 : 10'b0000000010; // S1
                10'b0000000100: next_state = in ? 10'b0000001000 : 10'b0000000100; // S2
                10'b0000001000: next_state = in ? 10'b0000010000 : 10'b0000001000; // S3
                10'b0000010000: next_state = in ? 10'b0000100000 : 10'b0000010000; // S4
                10'b0000100000: next_state = in ? 10'b0001000000 : 10'b0000100000; // S5
                10'b0001000000: next_state = in ? 10'b0010000000 : 10'b0001000000; // S6
                10'b0010000000: begin // S7
                    next_state = in ? 10'b0100000000 : 10'b0010000000;
                    out1 = 1'b0;
                    out2 = 1'b1;
                end
                10'b0100000000: begin // S8
                    next_state = in ? 10'b1000000000 : 10'b0100000000;
                    out1 = 1'b1;
                    out2 = 1'b0;
                end
                10'b1000000000: begin // S9
                    next_state = in ? 10'b0000000001 : 10'b1000000000;
                    out1 = 1'b1;
                    out2 = 1'b1;
                end
                default: next_state = 10'b0000000001; // Invalid state, default to S0
            endcase
        end
    end

endmodule