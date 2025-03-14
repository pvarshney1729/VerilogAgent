module TopModule (
    input logic [254:0] in,   // 255-bit input vector
    input logic clk,          // Clock signal
    input logic rst,          // Asynchronous reset signal
    output logic [7:0] out    // 8-bit output for population count
);

    // Internal signal for population count
    logic [7:0] count;

    // Combinational logic to calculate population count
    always @(*) begin
        count = 8'b0; // Initialize count to zero
        for (int i = 0; i < 255; i++) begin
            count = count + in[i]; // Sum the bits
        end
    end

    // Sequential logic for output update and reset handling
    always @(posedge clk) begin
        if (rst) begin
            out <= 8'b00000000; // Reset output to zero
        end else begin
            out <= count; // Update output with population count
        end
    end

endmodule