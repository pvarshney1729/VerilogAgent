[BEGIN]
module TopModule (
    input logic clk,
    input logic reset_n,
    input logic x,
    input logic [2:0] y,
    output logic Y0,
    output logic z
);

    logic [2:0] current_state, next_state;

    // State transition logic with synchronous reset
    always_ff @(posedge clk) begin
        if (!reset_n)
            current_state <= 3'b000;
        else
            current_state <= next_state;
    end

    // Next state and output logic
    always_comb begin
        // Default assignments
        next_state = 3'b000;
        z = 1'b0;

        case (current_state)
            3'b000: begin
                if (x == 1'b0)
                    next_state = 3'b000;
                else
                    next_state = 3'b001;
            end
            3'b001: begin
                if (x == 1'b0)
                    next_state = 3'b001;
                else
                    next_state = 3'b100;
            end
            3'b010: begin
                if (x == 1'b0)
                    next_state = 3'b010;
                else
                    next_state = 3'b001;
            end
            3'b011: begin
                if (x == 1'b0)
                    next_state = 3'b001;
                else
                    next_state = 3'b010;
                z = 1'b1;
            end
            3'b100: begin
                if (x == 1'b0)
                    next_state = 3'b011;
                else
                    next_state = 3'b100;
                z = 1'b1;
            end
            default: begin
                next_state = 3'b000; // Safe state for unused states
            end
        endcase
    end

    assign Y0 = next_state[0];

endmodule
[DONE]