module state_machine (
    input logic clk,
    input logic reset,
    output logic [2:0] state,
    output logic out
);

    logic [2:0] current_state, next_state;

    // State encoding
    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;
    parameter S5 = 3'b101;
    parameter S6 = 3'b110;
    parameter S7 = 3'b111;

    // Output logic based on current state
    always @(*) begin
        case (current_state)
            S0: out = 1'b0;
            S1: out = 1'b1;
            S2: out = 1'b0;
            S3: out = 1'b1;
            S4: out = 1'b0;
            S5: out = 1'b1;
            S6: out = 1'b0;
            S7: out = 1'b1;
            default: out = 1'b0;
        endcase
    end

    // State transition logic
    always @(*) begin
        case (current_state)
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S4;
            S4: next_state = S5;
            S5: next_state = S6;
            S6: next_state = S7;
            S7: next_state = S0;
            default: next_state = S0;
        endcase
    end

    // Sequential logic with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            current_state <= 3'b000; // Initialize to zero
        end else begin
            current_state <= next_state;
        end
    end

    // Assign output state
    assign state = current_state;

endmodule