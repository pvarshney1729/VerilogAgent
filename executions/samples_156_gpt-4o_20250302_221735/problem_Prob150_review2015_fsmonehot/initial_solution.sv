module TopModule (
    input logic d,                     // 1-bit input
    input logic done_counting,         // 1-bit input
    input logic ack,                   // 1-bit input
    input logic [9:0] state,           // 10-bit one-hot encoded state input
    output logic B3_next,              // 1-bit output
    output logic S_next,               // 1-bit output
    output logic S1_next,              // 1-bit output
    output logic S11_next,             // 1-bit output
    output logic S110_next,            // 1-bit output
    output logic B0_next,              // 1-bit output
    output logic Count_next,           // 1-bit output
    output logic Wait_next,            // 1-bit output
    output logic done,                 // 1-bit output
    output logic counting,             // 1-bit output
    output logic shift_ena             // 1-bit output
);

    // State encoding
    localparam S     = 10'b0000000001;
    localparam S1    = 10'b0000000010;
    localparam S11   = 10'b0000000100;
    localparam S110  = 10'b0000001000;
    localparam B0    = 10'b0000010000;
    localparam B1    = 10'b0000100000;
    localparam B2    = 10'b0001000000;
    localparam B3    = 10'b0010000000;
    localparam Count = 10'b0100000000;
    localparam Wait  = 10'b1000000000;

    // Next state logic
    always @(*) begin
        // Default assignments
        S_next = 1'b0;
        S1_next = 1'b0;
        S11_next = 1'b0;
        S110_next = 1'b0;
        B0_next = 1'b0;
        B3_next = 1'b0;
        Count_next = 1'b0;
        Wait_next = 1'b0;
        shift_ena = 1'b0;
        counting = 1'b0;
        done = 1'b0;

        case (state)
            S: begin
                if (d) S1_next = 1'b1;
                else S_next = 1'b1;
            end
            S1: begin
                if (d) S11_next = 1'b1;
                else S_next = 1'b1;
            end
            S11: begin
                if (d) S11_next = 1'b1;
                else S110_next = 1'b1;
            end
            S110: begin
                if (d) B0_next = 1'b1;
                else S_next = 1'b1;
            end
            B0: begin
                B3_next = 1'b1;
                shift_ena = 1'b1;
            end
            B1: begin
                B3_next = 1'b1;
                shift_ena = 1'b1;
            end
            B2: begin
                B3_next = 1'b1;
                shift_ena = 1'b1;
            end
            B3: begin
                Count_next = 1'b1;
                shift_ena = 1'b1;
            end
            Count: begin
                counting = 1'b1;
                if (done_counting) Wait_next = 1'b1;
                else Count_next = 1'b1;
            end
            Wait: begin
                done = 1'b1;
                if (ack) S_next = 1'b1;
                else Wait_next = 1'b1;
            end
            default: S_next = 1'b1; // Default to state S
        endcase
    end

endmodule