module TopModule (
    input logic clk,
    input logic areset,
    input logic x,
    output logic z
);

    typedef enum logic [1:0] {
        A = 2'b01,
        B = 2'b10
    } state_t;

    state_t state, next_state;

    // Sequential logic for state transition
    always @(posedge clk) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state and output
    always @(*) begin
        case (state)
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
                next_state = B;
                z = x ? 1'b0 : 1'b1;
            end
            default: begin
                next_state = A;
                z = 1'b0;
            end
        endcase
    end

endmodule