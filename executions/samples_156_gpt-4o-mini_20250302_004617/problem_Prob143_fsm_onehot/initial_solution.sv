module state_machine (
    input logic clk,
    input logic reset,
    input logic in,
    output logic out1,
    output logic out2
);

    logic [9:0] state, next_state;

    // State encoding
    localparam S0 = 10'b0000000001;
    localparam S1 = 10'b0000000010;
    localparam S2 = 10'b0000000100;
    localparam S3 = 10'b0000001000;
    localparam S4 = 10'b0000010000;
    localparam S5 = 10'b0000100000;
    localparam S6 = 10'b0001000000;
    localparam S7 = 10'b0010000000;
    localparam S8 = 10'b0100000000;
    localparam S9 = 10'b1000000000;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            state <= 10'b0000000000; // Initialize all flip-flops to zero
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            S0: next_state = in ? S1 : S0;
            S1: next_state = in ? S2 : S0;
            S2: next_state = in ? S3 : S1;
            S3: next_state = in ? S4 : S2;
            S4: next_state = in ? S5 : S3;
            S5: next_state = in ? S6 : S4;
            S6: next_state = in ? S7 : S5;
            S7: next_state = in ? S8 : S6;
            S8: next_state = in ? S9 : S7;
            S9: next_state = in ? S0 : S8;
            default: next_state = S0;
        endcase
    end

    // Output logic
    assign out1 = (state == S0) || (state == S2) || (state == S4) || (state == S6) || (state == S8);
    assign out2 = (state == S1) || (state == S3) || (state == S5) || (state == S7) || (state == S9);

endmodule