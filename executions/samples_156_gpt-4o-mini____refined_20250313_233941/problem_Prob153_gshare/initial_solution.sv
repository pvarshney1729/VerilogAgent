```
[BEGIN]
module TopModule (
    input  logic clk,
    input  logic areset,
    input  logic predict_valid,
    input  logic [6:0] predict_pc,
    output logic predict_taken,
    output logic [6:0] predict_history,
    input  logic train_valid,
    input  logic train_taken,
    input  logic train_mispredicted,
    input  logic [6:0] train_history,
    input  logic [6:0] train_pc
);

    logic [1:0] PHT [127:0]; // Pattern History Table
    logic [6:0] global_history; // Global History Register
    logic [6:0] index; // Index for PHT
    logic [1:0] pht_entry; // Current PHT entry
    logic [1:0] next_pht_entry; // Next PHT entry after training
    logic taken; // Prediction result

    // Asynchronous reset
    always_ff @(posedge clk) begin
        if (areset) begin
            global_history <= 7'b0;
            for (int i = 0; i < 128; i++) begin
                PHT[i] <= 2'b00; // Initialize PHT entries to weakly not taken
            end
        end else begin
            if (train_valid) begin
                // Update PHT based on training
                index <= train_pc ^ train_history; // XOR for index
                next_pht_entry <= PHT[index];
                if (train_taken) begin
                    if (next_pht_entry < 2'b11) next_pht_entry <= next_pht_entry + 1; // Increment
                end else begin
                    if (next_pht_entry > 2'b00) next_pht_entry <= next_pht_entry - 1; // Decrement
                end
                PHT[index] <= next_pht_entry; // Update PHT
                if (train_mispredicted) begin
                    global_history <= train_history; // Recover history on misprediction
                end
            end
            
            if (predict_valid) begin
                // Predict branch direction
                index <= predict_pc ^ global_history; // XOR for index
                pht_entry <= PHT[index];
                case (pht_entry)
                    2'b00, 2'b01: taken <= 1'b0; // Not taken
                    2'b10, 2'b11: taken <= 1'b1; // Taken
                endcase
                global_history <= {global_history[5:0], taken}; // Update history
            end
        end
    end

    assign predict_taken = taken;
    assign predict_history = global_history;

endmodule
[DONE]
```