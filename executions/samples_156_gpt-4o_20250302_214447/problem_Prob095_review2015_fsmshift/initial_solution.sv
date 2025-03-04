module TopModule (
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    logic [1:0] counter; // 2-bit counter to track the 4 cycles

    always_ff @(posedge clk) begin
        if (reset) begin
            shift_ena <= 1'b0;
            counter <= 2'b00;
        end else begin
            if (counter < 2'b11) begin
                shift_ena <= 1'b1;
                counter <= counter + 1'b1;
            end else begin
                shift_ena <= 1'b0;
            end
        end
    end

endmodule