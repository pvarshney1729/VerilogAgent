module TopModule (
    input logic in,
    input logic [9:0] state,
    output logic [9:0] next_state,
    output logic out1,
    output logic out2
);

    always @(*) begin
        // Default assignments
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
            10'b0000100000: next_state = in ? 10'b0001000000 : 10'b0001000000; // S5
            10'b0001000000: next_state = in ? 10'b0010000000 : 10'b1000000000; // S6
            10'b0010000000: next_state = in ? 10'b0010000000 : 10'b0000000001; // S7
            10'b0100000000: next_state = in ? 10'b0000000010 : 10'b0000000001; // S8
            10'b1000000000: next_state = in ? 10'b0000000010 : 10'b0000000001; // S9
            default: next_state = 10'b0000000001; // Default to S0
        endcase

        // Output logic
        case (state)
            10'b0010000000: out2 = 1'b1; // S7
            10'b0100000000: out1 = 1'b1; // S8
            10'b1000000000: begin // S9
                out1 = 1'b1;
                out2 = 1'b1;
            end
            default: begin
                out1 = 1'b0;
                out2 = 1'b0;
            end
        endcase
    end

endmodule