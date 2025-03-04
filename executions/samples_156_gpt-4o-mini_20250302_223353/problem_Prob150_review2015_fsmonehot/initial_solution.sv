module TopModule (
    input logic clk,             // Clock signal
    input logic reset_n,         // Active low reset signal
    input logic d,               // Input signal
    input logic done_counting,   // Input signal
    input logic ack,             // Input signal
    input logic [9:0] state,     // 10-bit state input for one-hot encoding
    output logic B3_next,        // Next-state signal for B3
    output logic S_next,         // Next-state signal for S
    output logic S1_next,        // Next-state signal for S1
    output logic Count_next,     // Next-state signal for Count
    output logic Wait_next,      // Next-state signal for Wait
    output logic done,           // Output done signal
    output logic counting,       // Output counting signal
    output logic shift_ena       // Output shift enable signal
);

    logic [9:0] current_state, next_state;

    // State encoding
    localparam S    = 10'b0000000001;
    localparam S1   = 10'b0000000010;
    localparam S11  = 10'b0000000100;
    localparam S110 = 10'b0000001000;
    localparam B0   = 10'b0000010000;
    localparam B1   = 10'b0000100000;
    localparam B2   = 10'b0001000000;
    localparam B3   = 10'b0010000000;
    localparam Count = 10'b0100000000;
    localparam Wait  = 10'b1000000000;

    // Sequential logic for state transitions
    always_ff @(posedge clk) begin
        if (!reset_n) begin
            current_state <= S; // Reset to state S
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state and outputs
    always_comb begin
        // Default values
        next_state = current_state;
        B3_next = 1'b0;
        S_next = 1'b0;
        S1_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;
        done = 1'b0;
        counting = 1'b0;
        shift_ena = 1'b0;

        case (current_state)
            S: begin
                if (d) next_state = S1;
            end
            S1: begin
                if (d) next_state = S11; else next_state = S;
            end
            S11: begin
                if (!d) next_state = S110;
            end
            S110: begin
                if (d) next_state = B0; else next_state = S;
            end
            B0: next_state = B1;
            B1: next_state = B2;
            B2: next_state = B3;
            B3: next_state = Count;
            Count: begin
                if (done_counting) next_state = Wait;
            end
            Wait: begin
                if (ack) next_state = S;
            end
            default: next_state = S; // Handle undefined states
        endcase

        // Output logic
        shift_ena = (current_state == B0) || (current_state == B1) || (current_state == B2) || (current_state == B3);
        counting = (current_state == Count);
        done = (current_state == Wait);
    end

endmodule