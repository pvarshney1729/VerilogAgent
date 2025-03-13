[BEGIN]
module TopModule (
    input  logic clk,
    input  logic load,
    input  logic [9:0] data,
    output logic tc
);

    logic [9:0] counter;

    always @(posedge clk) begin
        if (load) begin
            counter <= data; // Load the counter with data
        end else if (counter > 10'b0) begin
            counter <= counter - 10'b1; // Decrement the counter
        end
    end

    always @(*) begin
        tc = (counter == 10'b0); // Terminal count signal
    end

endmodule
[DONE]