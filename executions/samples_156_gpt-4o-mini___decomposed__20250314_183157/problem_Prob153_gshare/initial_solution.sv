module TopModule (
    input logic clk,
    input logic areset,
    input logic predict_valid,
    input logic [6:0] predict_pc,
    output logic predict_taken,
    output logic [6:0] predict_history,
    input logic train_valid,
    input logic train_taken,
    input logic train_mispredicted,
    input logic [6:0] train_history,
    input logic [6:0] train_pc
);
    // Internal signals
    logic [1:0] PHT [127:0]; // Pattern History Table
    logic [6:0] global_history; // Global history register
    logic [6:0] index; // Index for PHT

    // Hash function to get index
    assign index = predict_pc ^ global_history;

    always @(posedge clk) begin
        if (areset) begin
            global_history <= 7'b0; // Reset global history
            // Reset PHT entries
            integer i;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b00; // Initialize PHT
            end
        end else begin
            // Prediction logic
            if (predict_valid) begin
                predict_taken <= PHT[index][1]; // Predict taken from PHT
                predict_history <= global_history; // Output current history
                global_history <= {global_history[5:0], predict_taken}; // Update history
            end

            // Training logic
            if (train_valid) begin
                if (train_mispredicted) begin
                    global_history <= train_history; // Recover history on misprediction
                end else begin
                    global_history <= {global_history[5:0], train_taken}; // Update history
                end
                // Update PHT
                if (train_taken) begin
                    if (PHT[train_pc ^ global_history] < 2'b11) 
                        PHT[train_pc ^ global_history] <= PHT[train_pc ^ global_history] + 1; // Increment counter
                end else begin
                    if (PHT[train_pc ^ global_history] > 2'b00) 
                        PHT[train_pc ^ global_history] <= PHT[train_pc ^ global_history] - 1; // Decrement counter
                end
            end
        end
    end
endmodule