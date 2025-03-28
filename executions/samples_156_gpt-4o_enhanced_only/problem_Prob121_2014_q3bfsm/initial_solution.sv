module TopModule(
    input logic clk,
    input logic reset,
    input logic x,
    output logic z
);

    // State encoding
    typedef enum logic [2:0] {
        S0 = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011,
        S4 = 3'b100
    } state_t;
    
    state_t current_state, next_state;

    // Sequential logic: State transition and synchronous reset
    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic: Next state logic
    always_comb begin
        case (current_state)
            S0: next_state = (x == 1'b0) ? S0 : S1;
            S1: next_state = (x == 1'b0) ? S1 : S4;
            S2: next_state = (x == 1'b0) ? S2 : S1;
            S3: next_state = (x == 1'b0) ? S1 : S2;
            S4: next_state = (x == 1'b0) ? S3 : S4;
            default: next_state = S0; // Default case to handle unused states
        endcase
    end

    // Combinational logic: Output logic
    always_comb begin
        case (current_state)
            S3, S4: z = 1'b1;
            default: z = 1'b0;
        endcase
    end

endmodule