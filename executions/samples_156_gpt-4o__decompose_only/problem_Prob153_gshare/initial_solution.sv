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

    // Global history register
    logic [6:0] global_history;

    // Pattern history table (PHT) with 128 entries of 2-bit saturating counters
    logic [1:0] PHT [0:127];

    // Calculate the index for the PHT using XOR of PC and global history
    logic [6:0] predict_index;
    logic [6:0] train_index;
    assign predict_index = predict_pc ^ global_history;
    assign train_index = train_pc ^ train_history;

    // Predict taken based on the most significant bit of the PHT entry
    assign predict_taken = PHT[predict_index][1];

    // Output the current global history
    assign predict_history = global_history;

    // Sequential logic for updating the global history and PHT
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            // Asynchronous reset
            global_history <= 7'b0;
            for (int i = 0; i < 128; i++) begin
                PHT[i] <= 2'b01; // Initialize PHT to weakly not taken
            end
        end else begin
            if (train_valid) begin
                // Update PHT based on training
                if (train_taken) begin
                    if (PHT[train_index] != 2'b11) begin
                        PHT[train_index] <= PHT[train_index] + 1;
                    end
                end else begin
                    if (PHT[train_index] != 2'b00) begin
                        PHT[train_index] <= PHT[train_index] - 1;
                    end
                end

                // Update global history if mispredicted
                if (train_mispredicted) begin
                    global_history <= {train_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Update global history for prediction
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

endmodule