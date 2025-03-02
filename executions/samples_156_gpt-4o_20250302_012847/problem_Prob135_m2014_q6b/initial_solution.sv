```verilog
module TopModule (
    input logic clk,
    input logic rst_n,
    input logic w,
    output logic Y1
);

    // State encoding
    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    state_t y, y_next;

    // State transition logic
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            y <= A;
        else
            y <= y_next;
    end

    // Next state logic
    always_comb begin
        case (y)
            A: y_next = (w == 1'b0) ? B : A;
            B: y_next = (w == 1'b0) ? C : D;
            C: y_next = (w == 1'b0) ? E : D;
            D: y_next = (w == 1'b0) ? F : A;
            E: y_next = (w == 1'b0) ? E : D;
            F: y_next = (w == 1'b0) ? C : D;
            default: y_next = A; // Safe state transition
        endcase
    end

    // Output logic
    assign Y1 = y[1];

endmodule
```