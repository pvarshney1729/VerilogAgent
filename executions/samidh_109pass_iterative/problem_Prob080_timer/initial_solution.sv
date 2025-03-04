module TopModule (
    input logic clk,          // Clock signal, positive edge-triggered
    input logic load,         // Load signal, used to load the counter
    input logic [9:0] data,   // 10-bit data input for the countdown value
    output logic tc           // Terminal count output, indicates counter expiration
);

    logic [9:0] counter;      // Internal counter

    // Sequential logic for counter and terminal count
    always_ff @(posedge clk) begin
        if (load) begin
            counter <= data;
            tc <= (data == 10'b0);
        end else if (counter != 10'b0) begin
            counter <= counter - 1;
            tc <= (counter == 10'b1);
        end else begin
            tc <= 1'b1;
        end
    end

endmodule