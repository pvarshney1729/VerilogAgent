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

    // Global history register
    logic [6:0] global_history;

    // Pattern History Table (PHT) with 128 entries of 2-bit saturating counters
    logic [1:0] PHT [0:127];

    // Internal signals
    logic [6:0] predict_index;
    logic [6:0] train_index;
    logic [1:0] predict_counter;
    logic [1:0] train_counter;

    // Initialize PHT and global history register
    initial begin
        integer i;
        for (i = 0; i < 128; i = i + 1) begin
            PHT[i] = 2'b10; // Weakly taken state
        end
        global_history = 7'b0;
    end

    // Compute indices
    always @(*) begin
        predict_index = predict_pc ^ global_history;
        train_index = train_pc ^ train_history;
    end

    // Predict process
    always @(*) begin
        if (predict_valid) begin
            predict_counter = PHT[predict_index];
            predict_taken = (predict_counter[1] == 1'b1);
            predict_history = global_history;
        end else begin
            predict_taken = 1'b0; // Default value
            predict_history = global_history; // Maintain previous history
        end
    end

    // Training process
    always @(posedge clk) begin
        if (areset) begin
            global_history <= 7'b0;
            for (integer i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b10; // Reset PHT to weakly taken state
            end
        end else if (train_valid) begin
            train_counter = PHT[train_index];
            if (train_taken) begin
                if (train_counter != 2'b11) begin
                    PHT[train_index] <= train_counter + 2'b01;
                end
            end else begin
                if (train_counter != 2'b00) begin
                    PHT[train_index] <= train_counter - 2'b01;
                end
            end
            if (train_mispredicted) begin
                global_history <= train_history;
            end else begin
                global_history <= {global_history[5:0], train_taken};
            end
        end else if (predict_valid) begin
            global_history <= {global_history[5:0], predict_taken};
        end
    end

endmodule
```