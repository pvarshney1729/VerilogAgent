module TopModule (
    input logic clk,            // Clock signal
    input logic rst_n,          // Active-low reset signal
    input logic d,              // 1-bit input
    input logic done_counting,  // 1-bit input
    input logic ack,            // 1-bit input
    input logic [9:0] state,    // 10-bit one-hot encoded state input
    output logic B3_next,       // 1-bit output
    output logic S_next,        // 1-bit output
    output logic S1_next,       // 1-bit output
    output logic Count_next,     // 1-bit output
    output logic Wait_next,      // 1-bit output
    output logic done,           // 1-bit output
    output logic counting,       // 1-bit output
    output logic shift_ena       // 1-bit output
);

always @(*) begin
    // Reset all outputs
    B3_next = 0;
    S_next = 0;
    S1_next = 0;
    Count_next = 0;
    Wait_next = 0;
    done = 0;
    counting = 0;
    shift_ena = 0;

    case (state)
        10'b0000000001: begin // S
            if (d == 0) S_next = 1;
            else if (d == 1) S1_next = 1;
        end
        10'b0000000010: begin // S1
            if (d == 0) S_next = 1;
            else if (d == 1) S1_next = 1; // Assuming S11_next is a typo and should be S1_next
        end
        10'b0010000000: begin // B3
            B3_next = 1;
            shift_ena = 1;
        end
        10'b0100000000: begin // Count
            Count_next = 1;
            counting = 1;
        end
        10'b1000000000: begin // Wait
            Wait_next = 1;
            done = 1;
        end
        default: begin
            // Handle unexpected states
            S_next = 1;
        end
    endcase
end

endmodule