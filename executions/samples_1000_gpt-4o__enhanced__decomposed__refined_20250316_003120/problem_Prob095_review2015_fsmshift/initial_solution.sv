module TopModule (
    input  logic clk,
    input  logic reset,
    output logic shift_ena
);

    logic [2:0] cycle_count;

    always @(posedge clk) begin
        if (reset) begin
            cycle_count <= 3'b000;
            shift_ena <= 1'b1;
        end else if (shift_ena) begin
            if (cycle_count < 3'b011) begin
                cycle_count <= cycle_count + 1'b1;
            end else begin
                shift_ena <= 1'b0;
            end
        end
    end

endmodule