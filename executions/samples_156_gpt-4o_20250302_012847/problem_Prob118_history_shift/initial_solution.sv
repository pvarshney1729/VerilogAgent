module TopModule (
    input logic clk,
    input logic areset,
    input logic predict_valid,
    input logic train_mispredicted,
    output logic [31:0] predict_history
);

    // 32-bit shift register for predict_history
    logic [31:0] shift_reg;

    // Sequential logic for shift register with synchronous reset
    always_ff @(posedge clk) begin
        if (areset) begin
            shift_reg <= 32'b0;
        end else begin
            if (predict_valid) begin
                shift_reg <= {shift_reg[30:0], train_mispredicted};
            end
        end
    end

    // Assign the shift register to the output
    assign predict_history = shift_reg;

endmodule