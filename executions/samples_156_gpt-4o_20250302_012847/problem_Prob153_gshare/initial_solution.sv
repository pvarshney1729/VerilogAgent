```verilog
module TopModule (
    input logic clk,
    input logic reset,
    input logic [7:0] pc, // Program counter
    input logic branch_taken, // Actual branch outcome
    output logic prediction // Predicted branch outcome
);

    // Parameters
    parameter PHT_SIZE = 256; // Size of the Pattern History Table
    parameter BHR_WIDTH = 8;  // Width of the Global Branch History Register

    // Internal signals
    logic [BHR_WIDTH-1:0] bhr; // Global Branch History Register
    logic [1:0] pht [0:PHT_SIZE-1]; // Pattern History Table

    // Initialize flip-flops to zero
    initial begin
        bhr = '0;
        for (int i = 0; i < PHT_SIZE; i++) begin
            pht[i] = 2'b00;
        end
    end

    // Prediction logic
    always @(*) begin
        prediction = pht[{bhr, pc[BHR_WIDTH-1:0]}] >= 2'b10;
    end

    // Update logic for PHT and BHR
    always_ff @(posedge clk) begin
        if (reset) begin
            bhr <= '0;
            for (int i = 0; i < PHT_SIZE; i++) begin
                pht[i] <= 2'b00;
            end
        end else begin
            // Update PHT based on actual branch outcome
            if (branch_taken) begin
                if (pht[{bhr, pc[BHR_WIDTH-1:0]}] < 2'b11) begin
                    pht[{bhr, pc[BHR_WIDTH-1:0]}] <= pht[{bhr, pc[BHR_WIDTH-1:0]}] + 1;
                end
            end else begin
                if (pht[{bhr, pc[BHR_WIDTH-1:0]}] > 2'b00) begin
                    pht[{bhr, pc[BHR_WIDTH-1:0]}] <= pht[{bhr, pc[BHR_WIDTH-1:0]}] - 1;
                end
            end

            // Update BHR
            bhr <= {bhr[BHR_WIDTH-2:0], branch_taken};
        end
    end

endmodule
```