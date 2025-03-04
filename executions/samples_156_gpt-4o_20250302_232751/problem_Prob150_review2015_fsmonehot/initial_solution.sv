module TopModule (
    input logic d,
    input logic done_counting,
    input logic ack,
    input logic [9:0] state,
    output logic B3_next,
    output logic S_next,
    output logic S1_next,
    output logic Count_next,
    output logic Wait_next,
    output logic done,
    output logic counting,
    output logic shift_ena
);

    // Next state logic
    always @(*) begin
        // Default assignments
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;

        case (state)
            10'b0000000001: begin // S
                if (d) S1_next = 1'b1;
                else S_next = 1'b1;
            end
            10'b0000000010: begin // S1
                if (d) S1_next = 1'b1;
                else S_next = 1'b1;
            end
            10'b0000000100: begin // S11
                if (d) S1_next = 1'b1;
                else S_next = 1'b1;
            end
            10'b0000001000: begin // S110
                if (d) S1_next = 1'b1;
                else S_next = 1'b1;
            end
            10'b0000010000: S_next = 1'b1; // B0
            10'b0000100000: S_next = 1'b1; // B1
            10'b0001000000: S_next = 1'b1; // B2
            10'b0010000000: Count_next = 1'b1; // B3
            10'b0100000000: begin // Count
                if (done_counting) Wait_next = 1'b1;
                else Count_next = 1'b1;
            end
            10'b1000000000: begin // Wait
                if (ack) S_next = 1'b1;
                else Wait_next = 1'b1;
            end
            default: S_next = 1'b1; // Default to S
        endcase
    end

    // Output logic
    always @(*) begin
        // Default assignments
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            10'b0000010000, // B0
            10'b0000100000, // B1
            10'b0001000000, // B2
            10'b0010000000: shift_ena = 1'b1; // B3
            10'b0100000000: counting = 1'b1; // Count
            10'b1000000000: done = ~ack; // Wait
        endcase
    end

endmodule