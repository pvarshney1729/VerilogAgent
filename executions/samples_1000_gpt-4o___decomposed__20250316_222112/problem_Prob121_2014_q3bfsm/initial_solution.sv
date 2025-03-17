module TopModule (
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

    state_t state, next_state;

    // State transition logic
    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
        end else begin
            state <= next_state;
        end
    end

    // Next state and output logic
    always @(*) begin
        case (state)
            S0: begin
                next_state = (x == 1'b0) ? S0 : S1;
                z = 1'b0;
            end
            S1: begin
                next_state = (x == 1'b0) ? S1 : S4;
                z = 1'b0;
            end
            S2: begin
                next_state = (x == 1'b0) ? S2 : S1;
                z = 1'b0;
            end
            S3: begin
                next_state = (x == 1'b0) ? S1 : S2;
                z = 1'b1;
            end
            S4: begin
                next_state = (x == 1'b0) ? S3 : S4;
                z = 1'b1;
            end
            default: begin
                next_state = S0;
                z = 1'b0;
            end
        endcase
    end

endmodule