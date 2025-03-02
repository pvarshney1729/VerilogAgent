module TopModule (
    input  logic clk,
    input  logic reset,
    input  logic s,
    input  logic w,
    output logic z
);

    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01
    } state_t;

    state_t current_state, next_state;
    logic [2:0] w_count;

    // Sequential logic for state transitions
    always @(posedge clk) begin
        if (reset) begin
            current_state <= A;
            w_count <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == B) begin
                w_count <= {w_count[1:0], w}; // Shift in new w value
            end
        end
    end

    // Combinational logic for next state and output
    always @(*) begin
        case (current_state)
            A: begin
                if (s) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
                z = 1'b0; // Output z is 0 in state A
            end
            B: begin
                next_state = B; // Stay in B
                z = (w_count[2] + w_count[1] + w_count[0] == 3'b010) ? 1'b1 : 1'b0; // Check for exactly two 1's
            end
            default: begin
                next_state = A;
                z = 1'b0;
            end
        endcase
    end

endmodule