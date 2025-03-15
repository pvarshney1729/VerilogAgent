```verilog
module TopModule (
    input logic clk,
    input logic rst_n,
    input logic load,
    input logic [9:0] load_value,
    output logic [9:0] counter,
    output logic tc
);

    logic [9:0] count_reg;
    logic tc_reg;

    assign counter = count_reg;
    assign tc = tc_reg;

    always @(*) begin
        if (!rst_n) begin
            count_reg = 10'b0;
            tc_reg = 1'b0;
        end else if (load) begin
            count_reg = load_value;
            tc_reg = 1'b0;
        end else if (count_reg == 10'b1111111111) begin
            tc_reg = 1'b1;
            count_reg = count_reg; // Hold the value until load occurs
        end else begin
            count_reg = count_reg + 1'b1;
            tc_reg = 1'b0;
        end
    end

endmodule
```