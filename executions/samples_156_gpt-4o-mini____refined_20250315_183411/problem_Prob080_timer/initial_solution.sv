module TopModule (
    input logic clk,
    input logic load,
    input logic [9:0] data,
    output logic tc
);

    logic [9:0] counter;

    always @(posedge clk) begin
        if (load) begin
            counter <= data; // Load the counter with data
        end else if (counter > 0) begin
            counter <= counter - 1; // Decrement the counter
        end
    end

    assign tc = (counter == 0); // Terminal count signal

endmodule