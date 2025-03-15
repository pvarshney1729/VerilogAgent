module fsm (
    input logic clk,
    input logic rst_n,
    input logic [2:0] request,
    output logic [2:0] state
);

    typedef enum logic [2:0] {
        S0 = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011,
        S4 = 3'b100
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (!rst_n) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: next_state = (request == 3'b001) ? S1 : S0;
            S1: next_state = (request == 3'b010) ? S2 : S1;
            S2: next_state = (request == 3'b011) ? S3 : S2;
            S3: next_state = (request == 3'b100) ? S4 : S3;
            S4: next_state = (request == 3'b000) ? S0 : S4;
            default: next_state = S0;
        endcase
    end

    // Output state
    assign state = current_state;

endmodule