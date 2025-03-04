module TopModule (
    input wire clk,                // Clock input for synchronous logic
    input wire reset_n,            // Active-low reset input
    input wire d,                  // 1-bit input
    input wire done_counting,      // 1-bit input
    input wire ack,                // 1-bit input
    input wire [9:0] state,        // 10-bit input, one-hot encoded current state
    output reg B3_next,            // 1-bit output
    output reg S_next,             // 1-bit output
    output reg S1_next,            // 1-bit output
    output reg Count_next,         // 1-bit output
    output reg Wait_next,          // 1-bit output
    output reg done,               // 1-bit output
    output reg counting,           // 1-bit output
    output reg shift_ena           // 1-bit output
);

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
    localparam Wait = 10'b1000000000;

    reg [9:0] next_state;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            // Reset logic
            next_state <= S;
            B3_next <= 0;
            S_next <= 0;
            S1_next <= 0;
            Count_next <= 0;
            Wait_next <= 0;
            done <= 0;
            counting <= 0;
            shift_ena <= 0;
        end else begin
            // State transition logic
            case (state)
                S: begin
                    if (d == 0) next_state <= S;
                    else next_state <= S1;
                end
                S1: begin
                    if (d == 0) next_state <= S;
                    else next_state <= S11;
                end
                S11: begin
                    if (d == 0) next_state <= S110;
                    else next_state <= S11;
                end
                S110: begin
                    if (d == 0) next_state <= S;
                    else next_state <= B0;
                end
                B0: next_state <= B1;
                B1: next_state <= B2;
                B2: next_state <= B3;
                B3: next_state <= Count;
                Count: begin
                    if (done_counting == 0) next_state <= Count;
                    else next_state <= Wait;
                end
                Wait: begin
                    if (ack == 0) next_state <= Wait;
                    else next_state <= S;
                end
                default: next_state <= S;
            endcase

            // Output logic
            B3_next <= (next_state == B3);
            S_next <= (next_state == S);
            S1_next <= (next_state == S1);
            Count_next <= (next_state == Count);
            Wait_next <= (next_state == Wait);
            shift_ena <= (state == B0) || (state == B1) || (state == B2) || (state == B3);
            counting <= (state == Count);
            done <= (state == Wait);
        end
    end

endmodule