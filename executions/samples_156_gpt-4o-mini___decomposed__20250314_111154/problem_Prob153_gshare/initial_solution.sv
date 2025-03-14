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
    logic [6:0] global_history; // Global Branch History Register

    logic [6:0] index;
    logic [1:0] pht_entry;

    assign index = (predict_pc ^ global_history) & 7'b0111111; // XOR for index
    assign pht_entry = PHT[index];

    always @(posedge clk) begin
        if (areset) begin
            global_history <= 7'b0;
            // Reset PHT entries to weakly taken (01)
            for (integer i = 0; i < 128; i = i + 1) begin
                PHT[i] <= 2'b01; 
            end
        end else begin
            if (train_valid) begin
                // Update PHT based on training
                if (train_mispredicted) begin
                    global_history <= train_history; // Recover to the state after misprediction
                end else begin
                    global_history <= train_history; // Update global history
                end
                
                // Update PHT
                case (PHT[train_pc ^ global_history])
                    2'b00: PHT[train_pc ^ global_history] <= (train_taken) ? 2'b01 : 2'b00;
                    2'b01: PHT[train_pc ^ global_history] <= (train_taken) ? 2'b10 : 2'b00;
                    2'b10: PHT[train_pc ^ global_history] <= (train_taken) ? 2'b11 : 2'b01;
                    2'b11: PHT[train_pc ^ global_history] <= (train_taken) ? 2'b11 : 2'b10;
                endcase
            end
            
            if (predict_valid) begin
                // Output prediction and history
                predict_taken <= (pht_entry[1] == 1'b1); // Predict taken if the state is strong or weakly taken
                predict_history <= global_history; // Output current history
                global_history <= {global_history[5:0], predict_taken}; // Update global history
            end
        end
    end
endmodule