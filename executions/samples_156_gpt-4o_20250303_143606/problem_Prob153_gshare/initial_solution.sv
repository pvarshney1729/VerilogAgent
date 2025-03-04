```verilog
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

    // Parameters
    parameter PHT_SIZE = 128;
    parameter COUNTER_BITS = 2;

    // PHT: Pattern History Table
    logic [COUNTER_BITS-1:0] PHT [0:PHT_SIZE-1];

    // Global history register
    logic [6:0] global_history;

    // Internal signals
    logic [6:0] predict_index;
    logic [6:0] train_index;
    logic [COUNTER_BITS-1:0] counter_value;

    // Initialize PHT and global history on reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0000000;
            for (int i = 0; i < PHT_SIZE; i++) begin
                PHT[i] <= 2'b00;
            end
        end else begin
            if (train_valid) begin
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
                predict_index = predict_pc ^ global_history;
                counter_value = PHT[predict_index];
                predict_taken = counter_value[1];
                predict_history = global_history;
            end
        end
    end

endmodule
```