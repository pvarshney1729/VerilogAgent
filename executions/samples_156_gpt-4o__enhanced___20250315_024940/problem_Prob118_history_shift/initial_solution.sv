module TopModule (
    input  logic clk,
    input  logic areset,
    input  logic predict_valid,
    input  logic predict_taken,
    input  logic train_mispredicted,
    input  logic train_taken,
    input  logic [31:0] train_history,
    output logic [31:0] predict_history
);

    // Internal register to hold the history
    logic [31:0] history_reg;

    always @(posedge clk) begin
        if (areset) begin
            history_reg <= 32'b0; // Asynchronous reset
        end else if (train_mispredicted) begin
            history_reg <= {train_history[30:0], train_taken}; // Load history after misprediction
        end else if (predict_valid) begin
            history_reg <= {history_reg[30:0], predict_taken}; // Shift in predicted result
        end
    end

    assign predict_history = history_reg; // Output the current history

endmodule