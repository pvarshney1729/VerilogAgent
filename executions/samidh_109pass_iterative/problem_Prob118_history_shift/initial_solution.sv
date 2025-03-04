module TopModule (
    input  logic        clk,              // Clock signal, positive edge triggered
    input  logic        areset,           // Asynchronous reset, active high
    input  logic        predict_valid,    // Prediction valid signal
    input  logic        predict_taken,    // Prediction result (1: taken, 0: not taken)
    input  logic        train_mispredicted, // Misprediction signal
    input  logic        train_taken,      // Actual branch result (1: taken, 0: not taken)
    input  logic [31:0] train_history,    // History prior to mispredicted branch
    output logic [31:0] predict_history   // Current history register state
);

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            predict_history <= 32'b0;
        end else if (train_mispredicted) begin
            predict_history <= {train_history[30:0], train_taken};
        end else if (predict_valid) begin
            predict_history <= {predict_history[30:0], predict_taken};
        end
    end

endmodule