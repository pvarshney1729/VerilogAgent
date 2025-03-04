module gshare_predictor (
    input logic clk,
    input logic areset,
    input logic predict_valid,
    input logic [6:0] predict_pc,
    input logic train_valid,
    input logic train_taken,
    input logic train_mispredicted,
    input logic [6:0] train_history,
    input logic [6:0] train_pc,
    output logic predict_taken,
    output logic [6:0] predict_history
);

    logic [6:0] global_history;
    logic [1:0] PHT [127:0]; // 128 entries of 2-bit saturating counters
    logic [6:0] index;
    logic [1:0] counter_value;

    // Initialize PHT and global history on reset
    always_ff @(posedge clk) begin
        if (areset) begin
            global_history <= 7'b0;
            for (int i = 0; i < 128; i++) begin
                PHT[i] <= 2'b01; // Initialize to weakly taken
            end
        end else begin
            if (train_valid) begin
                // Training operation
                index <= (train_pc ^ global_history) [6:0];
                counter_value <= PHT[index];
                if (train_taken) begin
                    if (counter_value != 2'b11) begin
                        PHT[index] <= counter_value + 1;
                    end
                end else begin
                    if (counter_value != 2'b00) begin
                        PHT[index] <= counter_value - 1;
                    end
                end
                if (train_mispredicted) begin
                    global_history <= train_history; // Restore history on misprediction
                end else begin
                    global_history <= {global_history[5:0], train_taken}; // Update history
                end
            end
            if (predict_valid) begin
                // Prediction operation
                index <= (predict_pc ^ global_history) [6:0];
                counter_value <= PHT[index];
                predict_taken <= counter_value[1]; // MSB indicates taken
                predict_history <= global_history; // Output current history
            end
        end
    end

endmodule