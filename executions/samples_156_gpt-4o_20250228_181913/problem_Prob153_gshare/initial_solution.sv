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

    logic [6:0] global_history;
    logic [1:0] PHT [0:127];
    logic [6:0] predict_index, train_index;

    // Initialize PHT to weakly not-taken state (2'b01)
    initial begin
        integer i;
        for (i = 0; i < 128; i = i + 1) begin
            PHT[i] = 2'b01;
        end
    end

    // Asynchronous reset and global history update
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0000000;
        end else if (train_valid && train_mispredicted) begin
            global_history <= train_history;
        end else if (predict_valid || train_valid) begin
            global_history <= {global_history[5:0], (train_valid ? train_taken : predict_taken)};
        end
    end

    // Compute indices for prediction and training
    always_comb begin
        predict_index = predict_pc ^ global_history;
        train_index = train_pc ^ global_history;
    end

    // Prediction logic
    always_comb begin
        if (predict_valid) begin
            case (PHT[predict_index])
                2'b00, 2'b01: predict_taken = 1'b0;
                2'b10, 2'b11: predict_taken = 1'b1;
            endcase
            predict_history = global_history;
        end
    end

    // Training logic
    always_ff @(posedge clk) begin
        if (train_valid) begin
            case ({train_taken, PHT[train_index]})
                3'b100: PHT[train_index] <= 2'b10; // 01 -> 10
                3'b101: PHT[train_index] <= 2'b11; // 10 -> 11
                3'b110: PHT[train_index] <= 2'b11; // 11 -> 11
                3'b111: PHT[train_index] <= 2'b11; // 11 -> 11
                3'b000: PHT[train_index] <= 2'b00; // 00 -> 00
                3'b001: PHT[train_index] <= 2'b00; // 01 -> 00
                3'b010: PHT[train_index] <= 2'b01; // 10 -> 01
                3'b011: PHT[train_index] <= 2'b10; // 11 -> 10
            endcase
        end
    end

endmodule
```