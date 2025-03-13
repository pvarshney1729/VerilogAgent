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

    always @(posedge clk) begin
        if (reset) begin
            current_state <= A;
            w_count <= 3'b000;
        end else begin
            current_state <= next_state;
            if (current_state == B) begin
                w_count <= {w_count[1:0], w}; // Shift in the new w value
            end
        end
    end

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
                if (w_count == 3'b010 || w_count == 3'b001 || w_count == 3'b100) begin
                    z = 1'b1; // Exactly two 1's detected
                end else begin
                    z = 1'b0; // Otherwise
                end
                next_state = B; // Stay in state B
            end
            default: begin
                next_state = A;
            end
        endcase
    end

    assign z = (current_state == B) ? (w_count == 3'b010 || w_count == 3'b001 || w_count == 3'b100) : 1'b0;

endmodule