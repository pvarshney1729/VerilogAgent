module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic x,
    output logic z
);
    typedef enum logic [2:0] {
        S0 = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011,
        S4 = 3'b100
    } state_t;

    state_t current_state, next_state;

    // Sequential logic for state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Combinational logic for next state and output
    always @(*) begin
        case (current_state)
            S0: begin
                next_state = (x) ? S1 : S0;
                z = 1'b0;
            end
            S1: begin
                next_state = (x) ? S4 : S1;
                z = 1'b0;
            end
            S2: begin
                next_state = (x) ? S1 : S2;
                z = 1'b0;
            end
            S3: begin
                next_state = (x) ? S2 : S1;
                z = 1'b1;
            end
            S4: begin
                next_state = (x) ? S4 : S3;
                z = 1'b1;
            end
            default: begin
                next_state = S0;
                z = 1'b0;
            end
        endcase
    end
endmodule