module TopModule (
    input logic clk,
    input logic reset,
    input logic branch_taken,
    input logic [1:0] predict_history,
    output logic prediction,
    output logic [1:0] updated_history
);

    logic [1:0] history_reg;

    // Synchronous reset and history update logic
    always @(posedge clk) begin
        if (reset) begin
            history_reg <= 2'b00; // Initialize to zero on reset
        end else begin
            // Update history based on branch taken
            if (branch_taken) begin
                history_reg <= {history_reg[0], 1'b1}; // Shift in 1
            end else begin
                history_reg <= {history_reg[0], 1'b0}; // Shift in 0
            end
        end
    end

    // Prediction logic based on history
    always @(*) begin
        case (history_reg)
            2'b00: prediction = 1'b0; // Strongly not taken
            2'b01: prediction = 1'b0; // Weakly not taken
            2'b10: prediction = 1'b1; // Weakly taken
            2'b11: prediction = 1'b1; // Strongly taken
            default: prediction = 1'b0; // Default case
        endcase
    end

    // Assign updated history to output
    assign updated_history = history_reg;

endmodule