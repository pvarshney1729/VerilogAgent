```verilog
[BEGIN]
module TopModule (
    input logic clk,
    input logic a,
    output logic [2:0] q
);

    // Internal register to hold the state of q
    logic [2:0] q_reg;

    // Initialize q to 3'b000 at power-up
    initial begin
        q_reg = 3'b000;
    end

    // Sequential logic to update q on the rising edge of clk
    always_ff @(posedge clk) begin
        if (a == 1'b1) begin
            q_reg <= 3'b100;
        end else begin
            if (q_reg == 3'b110) begin
                q_reg <= 3'b000;
            end else begin
                q_reg <= q_reg + 3'b001;
            end
        end
    end

    // Assign the internal register to the output
    assign q = q_reg;

endmodule
[DONE]
```