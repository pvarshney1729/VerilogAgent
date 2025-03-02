module TopModule (
    input logic clk,               // Clock signal, positive edge-triggered
    input logic areset,            // Asynchronous reset, active-high

    input logic predict_valid,     // Prediction request valid signal
    input logic [6:0] predict_pc,  // 7-bit program counter for prediction
    output logic predict_taken,     // Predicted branch direction
    output logic [6:0] predict_history, // 7-bit branch history state used for prediction

    input logic train_valid,       // Training request valid signal
    input logic train_taken,       // Actual outcome of branch during training
    input logic train_mispredicted,// Indicates if the branch was mispredicted
    input logic [6:0] train_history, // 7-bit branch history during training
    input logic [6:0] train_pc    // 7-bit program counter during training
);

    logic [6:0] global_history;
    logic [1:0] PHT [127:0]; // 128-entry table of two-bit saturating counters

    // Initialize PHT and global_history on reset
    always @(posedge clk) begin
        if (areset) begin
            global_history <= 7'b0;
            for (int i = 0; i < 128; i++) begin
                PHT[i] <= 2'b10; // Initialize to weakly taken
            end
        end else begin
            if (train_valid) begin
                logic [6:0] index = train_pc ^ train_history;
                if (train_taken) begin
                    if (PHT[index] < 2'b11) PHT[index] <= PHT[index] + 1;
                end else begin
                    if (PHT[index] > 2'b00) PHT[index] <= PHT[index] - 1;
                end
                if (train_mispredicted) begin
                    global_history <= train_history; // Restore history on mispredict
                end
            end else if (predict_valid) begin
                logic [6:0] index = predict_pc ^ global_history;
                predict_taken <= (PHT[index] >= 2'b10);
                predict_history <= global_history;
            end
        end
    end

endmodule