[BEGIN]
```verilog
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

    logic [1:0] PHT [127:0]; // Pattern History Table
    logic [6:0] global_history; // Global history register
    logic [6:0] index; // Index for PHT
    logic [1:0] pht_entry; // Current PHT entry
    logic [1:0] next_pht_entry; // Next PHT entry after training

    // Calculate index using XOR of PC and global history
    assign index = predict_pc ^ global_history;

    // Combinational logic for prediction
    always @(*) begin
        pht_entry = PHT[index];
        case (pht_entry)
            2'b00: predict_taken = 1'b0; // Strongly not taken
            2'b01: predict_taken = 1'b0; // Weakly not taken
            2'b10: predict_taken = 1'b1; // Weakly taken
            2'b11: predict_taken = 1'b1; // Strongly taken
            default: predict_taken = 1'b0; // Default case
        endcase
        predict_history = global_history;
    end

    // Sequential logic for updating PHT and global history
    always @(posedge clk) begin
        if (areset) begin
            global_history <= 7'b0;
            for (int i = 0; i < 128; i++) begin
                PHT[i] <= 2'b0;
            end
        end else begin
            if (train_valid) begin
                // Update PHT based on training
                if (train_taken) begin
                    if (PHT[train_pc ^ train_history] < 2'b11) begin
                        next_pht_entry = PHT[train_pc ^ train_history] + 2'b01;
                    end else begin
                        next_pht_entry = PHT[train_pc ^ train_history];
                    end
                end else begin
                    if (PHT[train_pc ^ train_history] > 2'b00) begin
                        next_pht_entry = PHT[train_pc ^ train_history] - 2'b01;
                    end else begin
                        next_pht_entry = PHT[train_pc ^ train_history];
                    end
                end
                PHT[train_pc ^ train_history] <= next_pht_entry;

                // Handle misprediction
                if (train_mispredicted) begin
                    global_history <= train_history; // Recover history
                end else begin
                    global_history <= {global_history[5:0], train_taken}; // Update history
                end
            end else if (predict_valid) begin
                // Update global history with predicted outcome
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

endmodule
```
[DONE]