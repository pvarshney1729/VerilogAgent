module TopModule(
    input logic clk,
    input logic [7:0] in,
    output logic [7:0] pedge
);

    logic [7:0] prev_in;

    always_ff @(posedge clk) begin
        pedge <= (in & ~prev_in);
        prev_in <= in;
    end

endmodule