module TopModule (
    input logic clk,
    input logic shift_ena,
    input logic count_ena,
    input logic data,
    output logic [3:0] q
);

    // Internal register to hold the shift register value
    logic [3:0] shift_reg;

    // Synchronous logic for the shift register and down counter
    always @(posedge clk) begin
        if (shift_ena) begin
            // Shift left and insert new data at the LSB
            shift_reg <= {shift_reg[2:0], data};
        end else if (count_ena) begin
            // Down count
            if (shift_reg != 4'b0000) begin
                shift_reg <= shift_reg - 1;
            end
        end
    end

    // Assign the internal shift register to the output
    assign q = shift_reg;

    // Initialize the shift register to 0 on reset (implicitly done in simulation)
    initial begin
        shift_reg = 4'b0000;
    end

endmodule