module sequence_detector (
    input logic clk,
    input logic reset,
    input logic start_shifting,
    input logic data_in,
    output logic detected
);

    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10,
        S3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    always_ff @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
            detected <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

    always_ff @(posedge clk) begin
        if (current_state == S3) begin
            detected <= 1'b1;
        end else begin
            detected <= 1'b0;
        end
    end

    always_comb begin
        case (current_state)
            S0: begin
                if (data_in) next_state = S1;
                else next_state = S0;
            end
            S1: begin
                if (data_in) next_state = S2;
                else next_state = S0;
            end
            S2: begin
                if (~data_in) next_state = S3;
                else next_state = S2;
            end
            S3: begin
                if (start_shifting) next_state = S0;
                else next_state = S3;
            end
            default: next_state = S0;
        endcase
    end

endmodule