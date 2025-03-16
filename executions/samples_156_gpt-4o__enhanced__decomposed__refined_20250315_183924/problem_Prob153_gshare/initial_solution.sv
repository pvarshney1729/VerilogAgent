[BEGIN]
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

    // Parameters and internal signals
    logic [1:0] PHT [0:127]; // 128-entry Pattern History Table with 2-bit counters
    logic [6:0] global_history; // 7-bit global branch history register
    logic [6:0] predict_index;
    logic [6:0] train_index;
    integer i;

    // Calculate index using XOR for prediction and training
    always_comb begin
        predict_index = predict_pc ^ global_history;
        train_index = train_pc ^ train_history;
    end

    // Synchronous reset and update logic
    always_ff @(posedge clk) begin
        if (areset) begin
            global_history <= 7'b0;
            for (i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b00; // Initialize PHT counters to 00
            end
        end else begin
            // Training logic
            if (train_valid) begin
                // Update PHT entry based on actual outcome
                if (train_taken) begin
                    if (PHT[train_index] < 2'b11) PHT[train_index] <= PHT[train_index] + 1'b1;
                end else begin
                    if (PHT[train_index] > 2'b00) PHT[train_index] <= PHT[train_index] - 1'b1;
                end

                // Handle misprediction recovery
                if (train_mispredicted) begin
                    global_history <= {train_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Prediction logic
                predict_history <= global_history;
                case (PHT[predict_index])
                    2'b00, 2'b01: predict_taken <= 1'b0;
                    2'b10, 2'b11: predict_taken <= 1'b1;
                endcase

                // Update global history based on prediction
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

endmodule
[DONE]