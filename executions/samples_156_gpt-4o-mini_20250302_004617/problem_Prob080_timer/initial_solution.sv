module counter (
    input logic clk,
    input logic rst_n,
    input logic [9:0] load_val,
    output logic [9:0] count,
    output logic terminal_count
);

    logic [9:0] count_reg;

    // Synchronous reset and counting logic
    always @(posedge clk) begin
        if (!rst_n) begin
            count_reg <= 10'b0; // Initialize to zero on reset
        end else if (count_reg == 10'b1111111111) begin
            count_reg <= 10'b0; // Reset count on terminal count
        end else begin
            count_reg <= count_reg + 1'b1; // Increment count
        end
    end

    // Load value logic
    always @(posedge clk) begin
        if (!rst_n) begin
            count_reg <= 10'b0; // Initialize to zero on reset
        end else begin
            count_reg <= load_val; // Load value when not resetting
        end
    end

    assign count = count_reg;
    assign terminal_count = (count_reg == 10'b1111111111);

endmodule