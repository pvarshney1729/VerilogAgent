module sequence_detector (
    input logic clk,
    input logic reset,
    input logic din,
    output logic detected
);

    typedef enum logic [2:0] {
        S0 = 3'b000,
        S1 = 3'b001,
        S2 = 3'b010,
        S3 = 3'b011,
        S4 = 3'b100
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    always_comb begin
        case (current_state)
            S0: begin
                if (din) next_state = S1;
                else next_state = S0;
                detected = 1'b0;
            end
            S1: begin
                if (din) next_state = S2;
                else next_state = S0;
                detected = 1'b0;
            end
            S2: begin
                if (din) next_state = S3;
                else next_state = S0;
                detected = 1'b0;
            end
            S3: begin
                if (din) next_state = S4;
                else next_state = S0;
                detected = 1'b0;
            end
            S4: begin
                next_state = S0;
                detected = 1'b1;
            end
            default: begin
                next_state = S0;
                detected = 1'b0;
            end
        endcase
    end

endmodule