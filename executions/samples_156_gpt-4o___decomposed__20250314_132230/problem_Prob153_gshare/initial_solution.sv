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

    // Define the table of two-bit saturating counters
    logic [1:0] PHT [0:127]; // Pattern History Table with 128 entries

    // Global branch history register
    logic [6:0] global_history;

    // Internal wires for index calculation
    logic [6:0] predict_index;
    logic [6:0] train_index;

    // Calculate the index for prediction and training
    assign predict_index = predict_pc ^ global_history;
    assign train_index = train_pc ^ train_history;

    // Asynchronous reset and sequential logic
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            // Initialize PHT and global history on reset
            for (int i = 0; i < 128; i++) begin
                PHT[i] <= 2'b01; // Weakly not taken
            end
            global_history <= 7'b0;
        end else begin
            // Training logic
            if (train_valid) begin
                // Update the PHT based on the actual outcome
                if (train_taken) begin
                    if (PHT[train_index] < 2'b11) begin
                        PHT[train_index] <= PHT[train_index] + 1;
                    end
                end else begin
                    if (PHT[train_index] > 2'b00) begin
                        PHT[train_index] <= PHT[train_index] - 1;
                    end
                end

                // Update global history on misprediction recovery
                if (train_mispredicted) begin
                    global_history <= {train_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Update global history with the predicted outcome
                global_history <= {global_history[5:0], (PHT[predict_index] > 2'b01)};
            end
        end
    end

    // Output prediction logic
    always_comb begin
        if (predict_valid) begin
            predict_taken = (PHT[predict_index] > 2'b01);
            predict_history = global_history;
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'b0;
        end
    end

endmodule