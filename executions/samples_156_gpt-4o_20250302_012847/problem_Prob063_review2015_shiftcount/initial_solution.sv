module counter_module (
    input logic clk,
    input logic reset,
    input logic shift_ena,
    input logic count_ena,
    output logic [3:0] counter
);

    // Initialize counter to zero
    initial begin
        counter = 4'b0000;
    end

    always_ff @(posedge clk) begin
        if (reset) begin
            counter <= 4'b0000;
        end else begin
            if (count_ena) begin
                if (counter == 4'b0000) begin
                    counter <= 4'b1111; // Wrap-around behavior
                end else begin
                    counter <= counter - 1;
                end
            end
            if (shift_ena) begin
                counter <= {counter[2:0], counter[3]}; // Shift left with wrap-around
            end
        end
    end

endmodule