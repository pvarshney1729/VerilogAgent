[BEGIN]
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
    logic training_active;

    // Calculate index for PHT
    assign index = (predict_pc ^ global_history) [6:0];

    // Prediction logic
    always @(*) begin
        if (predict_valid) begin
            current_state = PHT[index];
            predict_taken = (current_state[1] == 1'b1);
            predict_history = global_history;
        end else begin
            predict_taken = 1'b0;
            predict_history = 7'b0;
        end
    end

    // Training logic
    always @(*) begin
        training_active = train_valid;
        if (training_active) begin
            if (train_mispredicted) begin
                global_history = train_history; // Recover history on misprediction
            end
            // Update PHT based on train_taken
            case (PHT[index])
                2'b00: next_state = train_taken ? 2'b01 : 2'b00;
                2'b01: next_state = train_taken ? 2'b10 : 2'b00;
                2'b10: next_state = train_taken ? 2'b11 : 2'b01;
                2'b11: next_state = train_taken ? 2'b11 : 2'b10;
                default: next_state = current_state; // Default case
            endcase
        end else begin
            next_state = current_state; // No training, keep current state
        end
    end

    // Sequential logic for updating PHT and global history
    always @(posedge clk) begin
        if (areset) begin
            global_history <= 7'b0;
            for (int i = 0; i < 128; i++) begin
                PHT[i] <= 2'b00;
            end
        end else begin
            if (training_active) begin
                PHT[index] <= next_state;
                global_history <= (predict_valid) ? current_state : global_history;
            end
        end
    end

endmodule
[DONE]