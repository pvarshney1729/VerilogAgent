module TopModule (
    input  logic clk,
    input  logic areset,
    input  logic x,
    output logic z
);

    typedef enum logic [1:0] {
        A = 2'b01,
        B = 2'b10
    } state_t;

    state_t current_state, next_state;

    // Asynchronous reset to state A
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        case (current_state)
            A: begin
                if (x) begin
                    next_state = B;
                    z = 1'b1;
                end else begin
                    next_state = A;
                    z = 1'b0;
                end
            end
            B: begin
                if (x) begin
                    next_state = B;
                    z = 1'b0;
                end else begin
                    next_state = B;
                    z = 1'b1;
                end
            end
            default: begin
                next_state = A;
                z = 1'b0;
            end
        endcase
    end

endmodule