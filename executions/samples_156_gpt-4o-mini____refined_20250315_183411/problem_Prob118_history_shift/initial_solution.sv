[BEGIN]
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

    logic [31:0] history_reg;

    always @(posedge clk) begin
        if (areset) begin
            history_reg <= 32'b0;
        end else if (train_mispredicted) begin
            history_reg <= {train_taken, train_history[31:1]};
        end else if (predict_valid) begin
            history_reg <= {predict_taken, history_reg[31:1]};
        end
    end

    assign predict_history = history_reg;

endmodule
[DONE]