module TopModule (
    input logic clk,
    input logic areset,
    input logic predict_valid,
    input logic predict_taken,
    input logic train_mispredicted,
    input logic train_taken,
    input logic [31:0] train_history,
    output logic [31:0] predict_history
);

    // Internal register to hold the current branch history
    logic [31:0] history_reg;

    // Sequential logic to update the history register
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset: reset history to zero
            history_reg <= 32'b0;
        end else if (train_mispredicted) begin
            // On misprediction, load history with train_history and train_taken
            history_reg <= {train_history[30:0], train_taken};
        end else if (predict_valid) begin
            // On valid prediction, shift in predict_taken
            history_reg <= {history_reg[30:0], predict_taken};
        end
    end

    // Assign the current history register to the output
    assign predict_history = history_reg;

endmodule