```verilog
module TopModule(
    input logic clk,
    input logic rst_n,
    input logic in,
    input logic [3:0] state,
    output logic [3:0] next_state,
    output logic out
);

    // State encoding
    localparam logic [3:0] A = 4'b0001;
    localparam logic [3:0] B = 4'b0010;
    localparam logic [3:0] C = 4'b0100;
    localparam logic [3:0] D = 4'b1000;

    // Next state logic
    always @(*) begin
        case (state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
            default: next_state = A; // Handle invalid state
        endcase
    end

    // Output logic
    always @(*) begin
        out = (state == D) ? 1'b1 : 1'b0;
    end

    // State transition logic
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            next_state <= A; // Asynchronous reset to state A
        end else begin
            next_state <= next_state; // Transition to next state
        end
    end

endmodule
```