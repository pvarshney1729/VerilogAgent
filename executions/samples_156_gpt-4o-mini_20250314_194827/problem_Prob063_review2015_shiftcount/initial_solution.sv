module shift_count(
    input logic clk,
    input logic reset,
    input logic shift_ena,
    input logic count_ena,
    output logic [7:0] data_out,
    output logic [3:0] count_out
);

    logic [7:0] data_reg;
    logic [3:0] count_reg;

    always @(*) begin
        if (shift_ena && count_ena) begin
            // Undefined operation when both are high
            data_out = 8'bxxxxxxxx;
            count_out = 4'bxxxx;
        end else if (shift_ena) begin
            data_out = {data_reg[6:0], 1'b0}; // Shift left
            count_out = count_reg; // Keep count unchanged
        end else if (count_ena) begin
            data_out = data_reg; // Keep data unchanged
            count_out = count_reg + 1'b1; // Increment count
        end else begin
            data_out = data_reg; // Keep data unchanged
            count_out = count_reg; // Keep count unchanged
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            data_reg <= 8'b00000000; // Initialize data to zero
            count_reg <= 4'b0000; // Initialize count to zero
        end else begin
            data_reg <= data_out; // Update data register
            count_reg <= count_out; // Update count register
        end
    end

endmodule