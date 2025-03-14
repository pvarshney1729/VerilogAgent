module TopModule (
    input logic clk,
    input logic areset,
    input logic train_valid,
    input logic train_taken,
    output logic [1:0] state
);

    logic [1:0] counter;

    always @(posedge clk) begin
        if (areset) begin
            counter <= 2'b01; // Reset to weakly not-taken
        end else if (train_valid) begin
            if (train_taken) begin
                if (counter < 2'b11) begin
                    counter <= counter + 2'b01; // Increment
                end
            end else begin
                if (counter > 2'b00) begin
                    counter <= counter - 2'b01; // Decrement
                end
            end
        end
    end

    assign state = counter; // Assign the current state of the counter to the output port state[1:0]

endmodule