module TopModule (
    input  logic clk,
    input  logic load,
    input  logic ena,
    input  logic [1:0] amount,
    input  logic [63:0] data,
    output logic [63:0] q
);

    // Internal register to hold the shift register value
    logic [63:0] shift_reg;

    // Synchronous process for shift register operation
    always @(posedge clk) begin
        if (load) begin
            // Load data into the shift register
            shift_reg <= data;
        end else if (ena) begin
            // Perform shifting operation based on amount
            case (amount)
                2'b00: shift_reg <= {shift_reg[62:0], 1'b0}; // Shift left by 1
                2'b01: shift_reg <= {shift_reg[55:0], 8'b0}; // Shift left by 8
                2'b10: shift_reg <= {shift_reg[63], shift_reg[63:1]}; // Arithmetic shift right by 1
                2'b11: shift_reg <= {shift_reg[63], shift_reg[63:8]}; // Arithmetic shift right by 8
                default: shift_reg <= shift_reg; // Default case (no change)
            endcase
        end
    end

    // Assign the output to the shift register value
    assign q = shift_reg;

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly