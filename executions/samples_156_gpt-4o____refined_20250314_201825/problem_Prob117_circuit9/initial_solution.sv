module TopModule (
    input  logic clk,
    input  logic a,
    output logic [2:0] q
);

    logic [2:0] state;

    always_ff @(posedge clk) begin
        if (a) begin
            state <= 3'b100;
        end else begin
            state <= state + 1;
        end
    end

    assign q = state;

endmodule