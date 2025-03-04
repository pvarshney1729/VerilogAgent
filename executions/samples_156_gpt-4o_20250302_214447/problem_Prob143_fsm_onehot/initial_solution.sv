module TopModule (
    input logic clk,               // Clock signal for synchronous operation
    input logic reset_n,           // Active-low asynchronous reset
    input logic in,                // 1-bit input for state transitions
    input logic [9:0] state,       // 10-bit one-hot encoded current state
    output logic [9:0] next_state, // 10-bit one-hot encoded next state
    output logic out1,             // 1-bit output corresponding to FSM output
    output logic out2              // 1-bit output corresponding to FSM output
);

    // State encoding
    localparam logic [9:0] S0 = 10'b0000000001;
    localparam logic [9:0] S1 = 10'b0000000010;
    localparam logic [9:0] S2 = 10'b0000000100;
    localparam logic [9:0] S3 = 10'b0000001000;
    localparam logic [9:0] S4 = 10'b0000010000;
    localparam logic [9:0] S5 = 10'b0000100000;
    localparam logic [9:0] S6 = 10'b0001000000;
    localparam logic [9:0] S7 = 10'b0010000000;
    localparam logic [9:0] S8 = 10'b0100000000;
    localparam logic [9:0] S9 = 10'b1000000000;

    // State transition logic
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            next_state <= S0;
        end else begin
            case (state)
                S0: next_state <= in ? S1 : S0;
                S1: next_state <= in ? S2 : S0;
                S2: next_state <= in ? S3 : S0;
                S3: next_state <= in ? S4 : S0;
                S4: next_state <= in ? S5 : S0;
                S5: next_state <= in ? S6 : S0;
                S6: next_state <= in ? S7 : S0;
                S7: next_state <= in ? S8 : S0;
                S8: next_state <= in ? S9 : S0;
                S9: next_state <= in ? S1 : S0;
                default: next_state <= S0; // Undefined state fallback
            endcase
        end
    end

    // Output logic
    always_comb begin
        case (state)
            S7: begin
                out1 = 1'b0;
                out2 = 1'b1;
            end
            S8: begin
                out1 = 1'b1;
                out2 = 1'b0;
            end
            S9: begin
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