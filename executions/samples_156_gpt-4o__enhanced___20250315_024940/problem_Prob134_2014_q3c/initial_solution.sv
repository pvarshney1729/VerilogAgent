module TopModule (
    input  logic clk,
    input  logic x,
    input  logic [2:0] y,
    output logic Y0,
    output logic z
);

    logic [2:0] next_state;

    // Next state logic
    always @(*) begin
        case (y)
            3'b000: next_state = (x) ? 3'b001 : 3'b000;
            3'b001: next_state = (x) ? 3'b100 : 3'b001;
            3'b010: next_state = (x) ? 3'b001 : 3'b010;
            3'b011: next_state = (x) ? 3'b010 : 3'b001;
            3'b100: next_state = (x) ? 3'b100 : 3'b011;
            default: next_state = 3'b000; // default state
        endcase
    end

    // State register with synchronous reset
    always @(posedge clk) begin
        if (y == 3'b000) begin // Assuming synchronous reset condition
            next_state <= 3'b000; // Reset state
        end else begin
            next_state <= next_state;
        end
    end

    // Output logic
    assign Y0 = next_state[0];
    assign z = (y == 3'b011 || y == 3'b100) ? 1'b1 : 1'b0;

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly