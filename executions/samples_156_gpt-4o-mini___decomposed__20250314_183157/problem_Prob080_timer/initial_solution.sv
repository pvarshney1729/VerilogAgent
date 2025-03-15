module TopModule (
    input logic clk,
    input logic load,
    input logic [9:0] data,
    output logic tc
);
    logic [9:0] counter;

    always @(posedge clk) begin
        if (load) begin
            counter <= data; // Load counter with data
            tc <= 0; // Reset terminal count
        end else if (counter > 0) begin
            counter <= counter - 1; // Decrement counter
        end
        
        if (counter == 0) begin
            tc <= 1; // Assert terminal count when counter reaches 0
        end
    end
endmodule