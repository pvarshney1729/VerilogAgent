module TopModule (
    input logic clk,           // Clock signal (positive edge-triggered)
    input logic rst_n,         // Active-low reset signal
    input logic load,          // Load enable signal
    input logic [9:0] data,    // 10-bit unsigned input data
    output logic tc            // Terminal count output
);

    logic [9:0] counter;       // Internal counter

    always_ff @(posedge clk) begin
        if (!rst_n) begin
            counter <= 10'b0;
            tc <= 1'b0;
        end else begin
            if (load) begin
                counter <= data;
                tc <= (data == 10'b0) ? 1'b1 : 1'b0;
            end else if (counter != 10'b0) begin
                counter <= counter - 1'b1;
                if (counter == 10'b1) begin
                    tc <= 1'b1;
                end
            end else begin
                tc <= 1'b1;
            end
        end
    end

endmodule