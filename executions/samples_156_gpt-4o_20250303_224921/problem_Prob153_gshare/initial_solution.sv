```verilog
module branch_predictor (
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

    // Define the PHT as an array of 2-bit counters
    logic [1:0] PHT [0:127];
    logic [6:0] global_history;

    // Initialize PHT and global history
    initial begin
        integer i;
        for (i = 0; i < 128; i = i + 1) begin
            PHT[i] = 2'b01; // Weakly not taken
        end
        global_history = 7'b0;
    end

    // Predict logic
    always @(*) begin
        if (predict_valid) begin
            logic [6:0] index;
            index = predict_pc ^ global_history;
            predict_taken = PHT[index][1]; // MSB of the counter
            predict_history = global_history;
        end
    end

    // Sequential logic for updating global history and training
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
        end else begin
            if (train_valid) begin
                logic [6:0] train_index;
                train_index = train_pc ^ train_history;
                if (train_taken) begin
                    if (PHT[train_index] < 2'b11) begin
                        PHT[train_index] <= PHT[train_index] + 1;
                    end
                end else begin
                    if (PHT[train_index] > 2'b00) begin
                        PHT[train_index] <= PHT[train_index] - 1;
                    end
                end
                if (train_mispredicted) begin
                    global_history <= train_history;
                end
            end else if (predict_valid) begin
                global_history <= {global_history[5:0], predict_taken};
            end
        end
    end

endmodule
```