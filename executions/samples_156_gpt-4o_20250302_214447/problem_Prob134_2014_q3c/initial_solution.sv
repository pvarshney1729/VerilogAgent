```verilog
module TopModule (
    input logic clk,
    input logic reset_n,
    input logic [2:0] y,
    input logic x,
    output logic Y0,
    output logic z
);

    logic [2:0] next_state;

    // Combinational logic for next state and output z
    always @(*) begin
        case (y)
            3'b000: begin
                next_state = (x == 1'b0) ? 3'b000 : 3'b001;
                z = 1'b0;
            end
            3'b001: begin
                next_state = (x == 1'b0) ? 3'b001 : 3'b100;
                z = 1'b0;
            end
            3'b010: begin
                next_state = (x == 1'b0) ? 3'b010 : 3'b001;
                z = 1'b0;
            end
            3'b011: begin
                next_state = (x == 1'b0) ? 3'b001 : 3'b010;
                z = 1'b1;
            end
            3'b100: begin
                next_state = (x == 1'b0) ? 3'b011 : 3'b100;
                z = 1'b1;
            end
            default: begin
                next_state = y;
                z = 1'b0;
            end
        endcase
    end

    // Sequential logic for state transition
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            next_state <= 3'b000;
        else
            next_state <= next_state;
    end

    // Output logic for Y0
    assign Y0 = next_state[0];

endmodule
```