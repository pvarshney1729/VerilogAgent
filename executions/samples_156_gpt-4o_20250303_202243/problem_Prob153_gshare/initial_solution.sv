```verilog
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

    // Define the PHT as a 128-entry array of 2-bit saturating counters
    logic [1:0] PHT [0:127];
    logic [6:0] global_history;

    // Initialize the PHT and global history on reset
    always_ff @(posedge clk) begin
        if (areset) begin
            global_history <= 7'b0;
            for (int i = 0; i < 128; i++) begin
                PHT[i] <= 2'b01; // Weakly not taken
            end
        end else begin
            if (train_valid) begin
                // Calculate the index for training
                logic [6:0] train_index = train_pc ^ train_history;
                // Update the PHT based on train_taken
                if (train_taken) begin
                    if (PHT[train_index] < 2'b11) begin
                        PHT[train_index] <= PHT[train_index] + 1;
                    end
                end else begin
                    if (PHT[train_index] > 2'b00) begin
                        PHT[train_index] <= PHT[train_index] - 1;
                    end
                end
                // Update global history if not mispredicted
                if (!train_mispredicted) begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end else if (predict_valid) begin
                // Update global history on prediction
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

    // Combinational logic for prediction
    always_comb begin
        if (predict_valid) begin
            // Calculate the index for prediction
            logic [6:0] predict_index = predict_pc ^ global_history;
            // Determine predict_taken based on the PHT entry
            predict_taken = (PHT[predict_index] >= 2'b10);
            // Output the current global history
            predict_history = global_history;
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'b0;
        end
    end

endmodule
```