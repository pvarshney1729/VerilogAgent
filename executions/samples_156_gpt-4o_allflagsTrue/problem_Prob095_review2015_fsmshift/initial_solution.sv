module TopModule(
    input logic clk,
    input logic reset,
    output logic shift_ena
);

    logic [2:0] shift_counter;

    always @(posedge clk) begin
        if (reset) begin
            shift_counter <= 3'd4; // Initialize counter to 4
        end else if (shift_counter != 3'd0) begin
            shift_counter <= shift_counter - 1;
        end
    end

    always @(*) begin
        shift_ena = (shift_counter != 3'd0);
    end

endmodule