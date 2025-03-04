module TopModule (
    input logic clk,            // Clock signal, positive edge-triggered
    input logic load,           // Load signal, active high
    input logic [9:0] data,     // 10-bit input data, data[9] is MSB, data[0] is LSB
    output logic tc             // Output terminal count, active high
);

    logic [9:0] counter;        // 10-bit internal counter

    // Initialize counter and tc
    initial begin
        counter = 10'b0;
        tc = 1'b0;
    end

    // Counter operation
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