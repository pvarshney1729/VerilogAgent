module TopModule (
    input logic clk,
    input logic reset,
    input logic in,
    output logic disc,
    output logic flag,
    output logic err
);

    logic [2:0] state, next_state;

    // State encoding
    localparam S0 = 3'b000; // Initial state
    localparam S1 = 3'b001; // 1 one detected (1)
    localparam S2 = 3'b010; // 2 ones detected (11)
    localparam S3 = 3'b011; // 3 ones detected (111)
    localparam S4 = 3'b100; // 4 ones detected (1111)
    localparam S5 = 3'b101; // 5 ones detected (11111)
    localparam S6 = 3'b110; // 6 ones detected (111111)
    localparam S7 = 3'b111; // Error state (7 or more)

    // State transition logic
    always @(*) begin
        case (state)
            S0: next_state = (in == 1'b1) ? S1 : S0;
            S1: next_state = (in == 1'b1) ? S2 : S0;
            S2: next_state = (in == 1'b1) ? S3 : S0;
            S3: next_state = (in == 1'b1) ? S4 : S0;
            S4: next_state = (in == 1'b1) ? S5 : S0;
            S5: next_state = (in == 1'b1) ? S6 : S0;
            S6: next_state = (in == 1'b1) ? S7 : S0; // Transition to error state
            S7: next_state = (in == 1'b1) ? S7 : S0; // Stay in error state
            default: next_state = S0;
        endcase
    end

    // State registers
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            disc <= 1'b0;
            flag <= 1'b0;
            err <= 1'b0;
        end else begin
            disc <= (state == S5) ? 1'b1 : 1'b0; // Assert disc for S5
            flag <= (state == S6 && in == 1'b0) ? 1'b1 : 1'b0; // Assert flag for S6 followed by 0
            err <= (state == S7) ? 1'b1 : 1'b0; // Assert err for S7
        end
    end

endmodule