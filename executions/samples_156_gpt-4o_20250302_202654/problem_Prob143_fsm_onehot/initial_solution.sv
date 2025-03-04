module TopModule(
    input logic in,                  // 1-bit input, unsigned
    input logic [9:0] state,         // 10-bit one-hot encoded state vector, unsigned
    output logic [9:0] next_state,   // 10-bit one-hot encoded next state vector, unsigned
    output logic out1,               // 1-bit output, unsigned
    output logic out2                // 1-bit output, unsigned
);

    always @(*) begin
        // Default outputs
        next_state = 10'b0000000000;
        out1 = 1'b0;
        out2 = 1'b0;

        // State transition and output logic
        if (state[0]) begin
            next_state = in ? 10'b0000000010 : 10'b0000000001;
        end else if (state[1]) begin
            next_state = in ? 10'b0000000100 : 10'b0000000010;
        end else if (state[2]) begin
            next_state = in ? 10'b0000001000 : 10'b0000000100;
        end else if (state[3]) begin
            next_state = in ? 10'b0000010000 : 10'b0000001000;
        end else if (state[4]) begin
            next_state = in ? 10'b0000100000 : 10'b0000010000;
        end else if (state[5]) begin
            next_state = in ? 10'b0001000000 : 10'b0000100000;
        end else if (state[6]) begin
            next_state = in ? 10'b0010000000 : 10'b0001000000;
        end else if (state[7]) begin
            next_state = in ? 10'b0100000000 : 10'b0010000000;
            out2 = 1'b1;
        end else if (state[8]) begin
            next_state = in ? 10'b1000000000 : 10'b0100000000;
            out1 = 1'b1;
        end else if (state[9]) begin
            next_state = in ? 10'b0000000001 : 10'b1000000000;
            out1 = 1'b1;
            out2 = 1'b1;
        end else begin
            // Handle undefined or erroneous states by transitioning to S0
            next_state = 10'b0000000001;
        end
    end

endmodule