```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic w,
    output logic z
);

    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            A: begin
                if (w == 1'b0) next_state = B;
                else next_state = A;
                z = 1'b0;
            end
            B: begin
                if (w == 1'b0) next_state = C;
                else next_state = D;
                z = 1'b0;
            end
            C: begin
                if (w == 1'b0) next_state = E;
                else next_state = D;
                z = 1'b0;
            end
            D: begin
                if (w == 1'b0) next_state = F;
                else next_state = A;
                z = 1'b0;
            end
            E: begin
                if (w == 1'b0) next_state = E;
                else next_state = D;
                z = 1'b1;
            end
            F: begin
                if (w == 1'b0) next_state = C;
                else next_state = D;
                z = 1'b1;
            end
            default: begin
                next_state = A;
                z = 1'b0;
            end
        endcase
    end

    // State register logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
        end
    end

endmodule
```