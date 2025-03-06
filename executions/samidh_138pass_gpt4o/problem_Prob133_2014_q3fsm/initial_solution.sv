```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic reset,
    input logic s,
    input logic w,
    output logic z
);

    typedef enum logic [1:0] {A, B} state_t;
    state_t state, next_state;

    logic [1:0] cycle_count;
    logic [1:0] w_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= A;
            z <= 1'b0;
            cycle_count <= 2'b00;
            w_count <= 2'b00;
        end else begin
            state <= next_state;
            if (state == B) begin
                cycle_count <= cycle_count + 1;
                if (w) w_count <= w_count + 1;
                if (cycle_count == 2'b10) begin
                    z <= (w_count == 2'b10) ? 1'b1 : 1'b0;
                    cycle_count <= 2'b00;
                    w_count <= 2'b00;
                end
            end
        end
    end

    always_ff @(*) begin
        next_state = state;
        case (state)
            A: if (s) next_state = B;
            B: if (cycle_count == 2'b10) next_state = B;
        endcase
    end

endmodule
[DONE]
```