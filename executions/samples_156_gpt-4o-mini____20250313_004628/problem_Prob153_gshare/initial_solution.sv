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

    logic [6:0] global_history;
    logic [1:0] PHT [127:0];
    logic [6:0] index;
    logic [1:0] current_state;
    logic [1:0] next_state;
    logic training_mispredicted;

    // Initialize PHT and global history on reset
    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            global_history <= 7'b0;
            for (int i = 0; i < 128; i++) begin
                PHT[i] <= 2'b00;
            end
        end else begin
            if (train_valid) begin
                index <= train_pc ^ train_history;
                if (train_mispredicted) begin
                    global_history <= train_history;
                end else begin
                    global_history <= {global_history[5:0], train_taken};
                end
                // Update PHT
                case (PHT[index])
                    2'b00: PHT[index] <= train_taken ? 2'b01 : 2'b00;
                    2'b01: PHT[index] <= train_taken ? 2'b10 : 2'b00;
                    2'b10: PHT[index] <= train_taken ? 2'b11 : 2'b01;
                    2'b11: PHT[index] <= train_taken ? 2'b11 : 2'b10;
                endcase
            end
        end
    end

    // Prediction logic
    always_ff @(posedge clk) begin
        if (predict_valid) begin
            index <= predict_pc ^ global_history;
            current_state <= PHT[index];
            predict_taken <= (current_state[1] == 1'b1);
            predict_history <= global_history;
            global_history <= {global_history[5:0], predict_taken};
        end
    end

endmodule