module TopModule (
    input logic clk,
    input logic reset,
    input logic s,
    input logic w,
    output logic z
);

    typedef enum logic [1:0] {
        A = 2'b00,  // State A
        B = 2'b01   // State B
    } state_t;

    state_t current_state, next_state;
    logic [2:0] w_count;  // 3-bit counter to count the occurrences of w = 1

    // Synchronous reset and state transition logic
    always @(*) begin
        case (current_state)
            A: begin
                if (s) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                next_state = B;  // Remain in state B
            end
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (reset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // Counter for the number of cycles with w = 1
    always @(posedge clk) begin
        if (reset) begin
            w_count <= 3'b000;
        end else if (current_state == B) begin
            w_count <= {w_count[1:0], w};  // Shift in the current value of w
        end else begin
            w_count <= 3'b000;  // Reset the counter when not in state B
        end
    end

    // Output logic for z based on the count of w
    always @(*) begin
        if (current_state == B) begin
            z = (w_count[0] + w_count[1] + w_count[2] == 3'b010) ? 1'b1 : 1'b0;
        end else begin
            z = 1'b0;  // Output z is 0 in state A
        end
    end

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly