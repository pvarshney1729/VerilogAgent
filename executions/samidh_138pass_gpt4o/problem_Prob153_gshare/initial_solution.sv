```verilog
[BEGIN]
module TopModule (
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
    logic [1:0] PHT [0:127]; // 2-bit saturating counters for 128 entries

    // Initialize PHT entries to 2'b01 (weakly not taken)
    initial begin
        integer i;
        for (i = 0; i < 128; i = i + 1) begin
            PHT[i] = 2'b01;
        end
    end

    // Synchronous reset and training logic
    always_ff @(posedge clk) begin
        if (areset) begin
            global_history <= 7'b0;
            for (integer j = 0; j < 128; j = j + 1) begin
                PHT[j] <= 2'b01;
            end
        end else begin
            if (train_valid) begin
                logic [6:0] train_index;
                train_index = train_pc ^ train_history;
                
                // Update PHT entry based on train_taken
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
                    global_history <= train_history;
                end else begin
                    global_history <= {global_history[5:0], train_taken};
                end
            end
        end
    end

    // Prediction logic
    always_comb begin
        if (predict_valid) begin
            logic [6:0] predict_index;
            predict_index = predict_pc ^ global_history;
            predict_taken = (PHT[predict_index] >= 2'b10);
            predict_history = global_history;
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'b0;
        end
    end

endmodule
[DONE]
```