module state_machine (
    input logic clk,
    input logic reset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        S0 = 2'b00,
        S1 = 2'b01,
        S2 = 2'b10,
        S3 = 2'b11
    } state_t;

    state_t current_state, next_state;

    // Synchronous reset and state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            S0: begin
                if (x) begin
                    next_state = S1;
                    z = 1'b0;
                end else begin
                    next_state = S0;
                    z = 1'b0;
                end
            end
            S1: begin
                if (x) begin
                    next_state = S2;
                    z = 1'b0;
                end else begin
                    next_state = S0;
                    z = 1'b0;
                end
            end
            S2: begin
                if (x) begin
                    next_state = S3;
                    z = 1'b0;
                end else begin
                    next_state = S0;
                    z = 1'b0;
                end
            end
            S3: begin
                if (x) begin
                    next_state = S3;
                    z = 1'b1;
                end else begin
                    next_state = S0;
                    z = 1'b0;
                end
            end
            default: begin
                next_state = S0;
                z = 1'b0;
            end
        endcase
    end

endmodule