module TopModule(
    input logic clk,
    input logic areset,
    input logic predict_valid,
    input logic predict_taken,
    input logic train_mispredicted,
    input logic train_taken,
    input logic [31:0] train_history,
    output logic [31:0] predict_history
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset: clear the history register
            predict_history <= 32'b0;
        end else if (train_mispredicted) begin
            // Load the history with train_history concatenated with train_taken
            predict_history <= {train_history[30:0], train_taken};
        end else if (predict_valid) begin
            // Shift in predict_taken into the LSB
            predict_history <= {predict_history[30:0], predict_taken};
        end
    end

endmodule