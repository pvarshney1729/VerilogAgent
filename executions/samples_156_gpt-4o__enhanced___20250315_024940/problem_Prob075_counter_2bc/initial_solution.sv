module TopModule (
    input logic clk,
    input logic areset,
    input logic train_valid,
    input logic train_taken,
    output logic [1:0] state
);

    logic [1:0] counter;

    // Asynchronous reset to weakly not-taken state (2'b01)
    always_ff @(*) begin
        if (areset) begin
            counter <= 2'b01;
        end else if (train_valid) begin
            if (train_taken && counter < 2'b11) begin
                counter <= counter + 1;
            end else if (!train_taken && counter > 2'b00) begin
                counter <= counter - 1;
            end
        end
    end

    assign state = counter;

endmodule

// VERILOG-EVAL: response did not use [BEGIN]/[DONE] correctly