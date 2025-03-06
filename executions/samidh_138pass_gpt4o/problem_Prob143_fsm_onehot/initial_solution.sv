module TopModule (
    input logic clk,            // Clock signal for synchronous operation
    input logic rst_n,          // Active-low reset signal
    input logic in,             // Single-bit input
    input logic [9:0] state,    // 10-bit one-hot encoded current state vector
    output logic [9:0] next_state, // 10-bit one-hot encoded next state vector
    output logic out1,          // Output 1
    output logic out2           // Output 2
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

    // Sequential logic for state transitions
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            next_state <= S0;
            out1 <= 1'b0;
            out2 <= 1'b0;
        end else begin
            case (state)
                S0: next_state <= in ? S1 : S0;
                S1: next_state <= in ? S2 : S1;
                S2: next_state <= in ? S3 : S2;
                S3: next_state <= in ? S4 : S3;
                S4: next_state <= in ? S5 : S4;
                S5: next_state <= in ? S6 : S5;
                S6: next_state <= in ? S7 : S6;
                S7: begin
                    next_state <= in ? S8 : S7;
                    out1 <= 1'b0;
                    out2 <= 1'b1;
                end
                S8: begin
                    next_state <= in ? S9 : S8;
                    out1 <= 1'b1;
                    out2 <= 1'b0;
                end
                S9: begin
                    next_state <= in ? S0 : S9;
                    out1 <= 1'b1;
                    out2 <= 1'b1;
                end
                default: begin
                    next_state <= S0;
                    out1 <= 1'b0;
                    out2 <= 1'b0;
                end
            endcase
        end
    end

    // Combinational logic to handle multiple active states
    always_comb begin
        if (^state !== 1'b1) begin
            next_state = S0;
            out1 = 1'b0;
            out2 = 1'b0;
        end
    end

endmodule