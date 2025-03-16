module TopModule (
    input logic clk,
    input logic reset,
    input logic data,
    output logic start_shifting
);
    typedef enum logic [1:0] {
        S0, // Initial state
        S1, // Found '1'
        S2, // Found '11'
        S3  // Found '110'
    } state_t;

    state_t current_state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
            start_shifting <= 0;
        end else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
            S0: begin
                if (data) next_state = S1;
                else next_state = S0;
                start_shifting = 0;
            end
            S1: begin
                if (data) next_state = S2;
                else next_state = S0;
                start_shifting = 0;
            end
            S2: begin
                if (~data) next_state = S3;
                else next_state = S2;
                start_shifting = 0;
            end
            S3: begin
                next_state = S3; // Stay in S3 once sequence is found
                start_shifting = 1; // Set output to 1
            end
            default: begin
                next_state = S0;
                start_shifting = 0;
            end
        endcase
    end
endmodule