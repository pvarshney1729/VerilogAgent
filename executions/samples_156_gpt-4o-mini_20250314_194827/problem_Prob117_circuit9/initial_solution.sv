module my_module (
    input logic clk,
    input logic rst_n,
    input logic a,
    output logic q
);
    logic state;

    always @(posedge clk) begin
        if (!rst_n) begin
            state <= 1'b0;
        end else begin
            state <= a; // Example state behavior
        end
    end

    assign q = state;

endmodule