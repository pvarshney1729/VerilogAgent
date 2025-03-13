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
    logic [6:0] global_history; // Global History Register
    logic [6:0] index; // Index for PHT
    logic [1:0] counter; // Counter for prediction

    // Synchronous reset
    always_ff @(posedge clk) begin
        if (areset) begin
            global_history <= 7'b0;
            for (int i = 0; i < 128; i++) begin
                PHT[i] <= 2'b00; // Initialize PHT to 0
            end
        end else begin
            if (train_valid) begin
                index <= train_pc ^ train_history; // Compute index
                if (train_mispredicted) begin
                    global_history <= train_history; // Recover history on misprediction
                end else begin
                    // Update PHT based on training outcome
                    if (train_taken) begin
                        if (PHT[index] < 2'b11) PHT[index] <= PHT[index] + 1; // Increment
                    end else begin
                        if (PHT[index] > 2'b00) PHT[index] <= PHT[index] - 1; // Decrement
                    end
                end
            end
            
            if (predict_valid) begin
                index <= predict_pc ^ global_history; // Compute index for prediction
                counter <= PHT[index]; // Read counter for prediction
                predict_taken <= (counter[1] == 1'b1); // Predict taken if counter is 2 or 3
                global_history <= {global_history[5:0], predict_taken}; // Update global history
            end
        end
    end

    // Output the current global history for prediction
    assign predict_history = global_history;

endmodule
```
[DONE]